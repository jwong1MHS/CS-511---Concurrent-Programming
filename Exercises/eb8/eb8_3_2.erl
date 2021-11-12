-module(eb8_3_2).
-compile(export_all).

start() ->
    S = spawn(?MODULE, server, [0]),
    spawn(?MODULE, client, [S]),
    S.

client(S) ->
    [ S!{continue} || _ <- lists:seq(1,rand:uniform(100)) ],
    S!{counter,self()},
    receive
        {data,State} ->
            io:format("Number of continues since last counter: ~p~n",[State]),
            client(S)
    end.

server(State) ->
    receive
        {continue} ->
            server(State+1);
        {counter,From} ->
            From!{data,State},
            server(0)
    end.