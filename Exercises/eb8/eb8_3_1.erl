-module(eb8_3_1).
-compile(export_all).

start() ->
    S = spawn(?MODULE, server, [0]),
    spawn(?MODULE, client, [S]),
    S.

client(S) ->
    S!{continue},
    S!{continue},
    S!{continue},
    S!{continue},
    S!{continue},
    S!{counter},
    S!{continue},
    S!{continue},
    S!{continue},
    S!{counter},
    S!{continue}.

server(State) ->
    receive
        {continue} ->
            server(State+1);
        {counter} ->
            io:format("Number of continues since last counter: ~p~n",[State]),
            server(0)
    end.