-module(eb8_2_1).
-compile(export_all).

start() ->
    S = spawn(?MODULE, server, [""]),
    [ spawn(?MODULE, client, [S]) || _ <- lists:seq (1 ,100000)].

client(S) ->
    S!{start, self()},
    S!{add, "h", self()},
    S!{add, "e", self()},
    S!{add, "l", self()},
    S!{add, "l", self()},
    S!{add, "o", self()},
    S!{done, self()},
    receive
        {S,Str} ->
            io:format("Done: ~p~s~n",[S,Str])
    end.

server(State) ->
    receive
        {start, _From} ->
            server("");
        {add, Data, _From} ->
            server(State ++ Data);
        {done, From} ->
            From!{self(),State}
    end.