-module(server).

-export([start_server/0]).

-include_lib("./defs.hrl").

-spec start_server() -> _.
-spec loop(_State) -> _.
-spec do_join(_ChatName, _ClientPID, _Ref, _State) -> _.
-spec do_leave(_ChatName, _ClientPID, _Ref, _State) -> _.
-spec do_new_nick(_State, _Ref, _ClientPID, _NewNick) -> _.
-spec do_client_quit(_State, _Ref, _ClientPID) -> _NewState.

start_server() ->
    catch(unregister(server)),
    register(server, self()),
    case whereis(testsuite) of
	undefined -> ok;
	TestSuitePID -> TestSuitePID!{server_up, self()}
    end,
    loop(
      #serv_st{
	 nicks = maps:new(), %% nickname map. client_pid => "nickname"
	 registrations = maps:new(), %% registration map. "chat_name" => [client_pids]
	 chatrooms = maps:new() %% chatroom map. "chat_name" => chat_pid
	}
     ).

loop(State) ->
    receive 
	%% initial connection
	{ClientPID, connect, ClientNick} ->
	    NewState =
		#serv_st{
		   nicks = maps:put(ClientPID, ClientNick, State#serv_st.nicks),
		   registrations = State#serv_st.registrations,
		   chatrooms = State#serv_st.chatrooms
		  },
	    loop(NewState);
	%% client requests to join a chat
	{ClientPID, Ref, join, ChatName} ->
	    NewState = do_join(ChatName, ClientPID, Ref, State),
	    loop(NewState);
	%% client requests to join a chat
	{ClientPID, Ref, leave, ChatName} ->
	    NewState = do_leave(ChatName, ClientPID, Ref, State),
	    loop(NewState);
	%% client requests to register a new nickname
	{ClientPID, Ref, nick, NewNick} ->
	    NewState = do_new_nick(State, Ref, ClientPID, NewNick),
	    loop(NewState);
	%% client requests to quit
	{ClientPID, Ref, quit} ->
	    NewState = do_client_quit(State, Ref, ClientPID),
	    loop(NewState);
	{TEST_PID, get_state} ->
	    TEST_PID!{get_state, State},
	    loop(State)
    end.

%% executes join protocol from server perspective
do_join(ChatName, ClientPID, Ref, State) ->
    case maps:find(ChatName, State#serv_st.chatrooms) of
		{ok, Value} ->
			ChatRoomPID = Value;
		error ->
			ChatRoomPID = spawn(chatroom, start_chatroom, [ChatName])
	end,
	case maps:find(ClientPID, State#serv_st.nicks) of
		{ok, ClientNick} ->
			% this makes no sense (line below this commment)..
			NewChatRooms = maps:put(ChatName, ChatRoomPID, State#serv_st.chatrooms),
			ChatRoomPID ! {self(), Ref, register, ClientPID, ClientNick},
			case maps:find(ChatName, State#serv_st.registrations) of
				{ok, Registered} ->
					% im erroring cause im not returning a state, retard...
					Updated = maps:put(ChatName, [ClientPID] ++ Registered, State#serv_st.registrations);
				error ->
					Updated = maps:put(ChatName, [ClientPID], State#serv_st.registrations)
			end
		%% does this ever error?????????
	end,

	% Take the previous state, but just update registrations, and keep the rest the same.
	NewState = State#serv_st{registrations = Updated, chatrooms = NewChatRooms},
	NewState.

%% executes leave protocol from server perspective
do_leave(ChatName, ClientPID, Ref, State) -> 
    case maps:find(ChatName, State#serv_st.chatrooms) of
		{ok, ChatRoomPID} ->
			ClientRemoved = maps:update_with(ChatName, fun(L) -> L -- [ClientPID] end, State#serv_st.registrations),
			ChatRoomPID ! {self(), Ref, unregister, ClientPID},
			ClientPID ! {self(), Ref, ack_leave},
			State#serv_st{registrations = ClientRemoved};
		error ->
			io:format("woops~n"),
			State
	end.

%% executes new nickname protocol from server perspective
do_new_nick(State, Ref, ClientPID, NewNick) ->
    case lists:member(NewNick, maps:values(State#serv_st.nicks)) of
		true ->
			ClientPID ! {self(), Ref, err_nick_used},
			State;
		false ->
			UpdatedNick = maps:update(ClientPID, NewNick, State#serv_st.nicks),
			FindClient = fun(_, V) -> lists:member(ClientPID, V) end,
			ClientRooms = maps:keys(maps:filter(FindClient, State#serv_st.registrations)),
			FindPID = 
				fun(RoomName) -> 
					maps:get(RoomName, State#serv_st.chatrooms) ! {self(), Ref, update_nick, ClientPID, NewNick}
				end,
			lists:foreach(FindPID, ClientRooms),
			ClientPID ! {self(), Ref, ok_nick},
			State#serv_st{nicks = UpdatedNick}
	end.

%% executes client quit protocol from server perspective
do_client_quit(State, Ref, ClientPID) ->
    RemovedNicks = maps:remove(ClientPID, State#serv_st.nicks),
	%% Find and filter map based upon if ClientPID is a member of the value list.
	FilterFun = fun(_, V) -> lists:member(ClientPID, V) == true end,
	FilteredMap = maps:filter(FilterFun, State#serv_st.registrations),

	%% Grab the keys (names) of the filtered map to use for the logic below.
	FilteredMapNames = maps:keys(FilteredMap),

	%% With the irrelevant chatrooms filtered, find the respective PIDs of the names by filtering again with membership test.
	FilterValuesToList = maps:values(maps:filter(fun(K, _) -> lists:member(K, FilteredMapNames) == true end, State#serv_st.chatrooms)),

	%% Finally iterate through each PID from the filtered list and send the message.
	lists:foreach(fun(PID) -> PID ! {self(), Ref, unregister, ClientPID} end, FilterValuesToList),
	RemovedClients = maps:map(fun(_, V) -> lists:delete(ClientPID, V) end, FilteredMap),
	ClientPID ! {self(), Ref, ack_quit},
	State#serv_st{nicks = RemovedNicks, registrations = RemovedClients}.