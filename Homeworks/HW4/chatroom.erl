-module(chatroom).

-include_lib("./defs.hrl").

-export([start_chatroom/1]).

-spec start_chatroom(_ChatName) -> _.
-spec loop(_State) -> _.
-spec do_register(_State, _Ref, _ClientPID, _ClientNick) -> _NewState.
-spec do_unregister(_State, _ClientPID) -> _NewState.
-spec do_update_nick(_State, _ClientPID, _NewNick) -> _NewState.
-spec do_propegate_message(_State, _Ref, _ClientPID, _Message) -> _NewState.

start_chatroom(ChatName) ->
    loop(#chat_st{name = ChatName,
		  registrations = maps:new(), history = []}),
    ok.

loop(State) ->
    NewState =
	receive
	    %% Server tells this chatroom to register a client
	    {_ServerPID, Ref, register, ClientPID, ClientNick} ->
		do_register(State, Ref, ClientPID, ClientNick);
	    %% Server tells this chatroom to unregister a client
	    {_ServerPID, _Ref, unregister, ClientPID} ->
		do_unregister(State, ClientPID);
	    %% Server tells this chatroom to update the nickname for a certain client
	    {_ServerPID, _Ref, update_nick, ClientPID, NewNick} ->
		do_update_nick(State, ClientPID, NewNick);
	    %% Client sends a new message to the chatroom, and the chatroom must
	    %% propegate to other registered clients
	    {ClientPID, Ref, message, Message} ->
		do_propegate_message(State, Ref, ClientPID, Message);
	    {TEST_PID, get_state} ->
		TEST_PID!{get_state, State},
		loop(State)
end,
    loop(NewState).

%% This function should register a new client to this chatroom
do_register(State, Ref, ClientPID, ClientNick) ->
    UpdatedReg = maps:put(ClientPID, ClientNick, State#chat_st.registrations),
	UpdatedState = State#chat_st{registrations = UpdatedReg},
	ClientPID ! {self(), Ref, connect, UpdatedState#chat_st.history},
	UpdatedState.
	
%% This function should unregister a client from this chatroom
do_unregister(State, ClientPID) ->
    Removed = maps:remove(ClientPID, State#chat_st.registrations),
	State#chat_st{registrations = Removed}.

%% This function should update the nickname of specified client.
do_update_nick(State, ClientPID, NewNick) ->
	UpdatedName = maps:update(ClientPID, NewNick, State#chat_st.registrations),
	State#chat_st{registrations = UpdatedName}.

%% This function should update all clients in chatroom with new message
%% (read assignment specs for details)
do_propegate_message(State, Ref, ClientPID, Message) ->
	ClientPID ! {self(), Ref, ack_msg},
	CliNick = maps:get(ClientPID, State#chat_st.registrations),
	FilteredClients = maps:keys(maps:filter(fun(K, _) -> K /= ClientPID end, State#chat_st.registrations)),
	lists:foreach(fun(K) ->
			K ! {request, self(), Ref, {incoming_msg, CliNick, State#chat_st.name, Message}} 
			end, FilteredClients),
	UpdatedHistory = State#chat_st.history ++ [{CliNick, Message}],
	State#chat_st{history = UpdatedHistory}.
