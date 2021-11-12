-module(eb8_2_2).
-compile(export_all).

start() ->
    S = spawn(?MODULE, server, []),
    [ spawn(?MODULE, client, [S]) || _ <- lists:seq(1,3)],
    S.

client(S) ->
    S!{start, self()},
    receive
        {ok, Servlet} ->
            client2(S, Servlet)
    end.

client2(S, Servlet) ->
    Servlet!{add, "h", self()},
    Servlet!{add, "e", self()},
    Servlet!{add, "l", self()},
    Servlet!{add, "l", self()},
    Servlet!{add, "o", self()},
    Servlet!{done, self()},
    receive
        {Str} ->
            io:format("Done: ~p~s~n", [self(), Str])
    end.

server() ->
    receive
        {start, From} ->
            Servlet = spawn(?MODULE, servlet, [""]),
            From!{ok, Servlet},
            server()
    end.

servlet(State) ->
    receive
        {add, S, From} ->
            servlet(State ++ S);
        {done, From} ->
            From!{State},
            servlet(State)
    end.