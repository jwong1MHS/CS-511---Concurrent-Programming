-module(cl).
-compile(export_all).


start() ->
    S = sem:start_sem(0),
    spawn(?MODULE,client1,[S]),
    spawn(?MODULE,client2,[S]).

%% C after A

client1(S) ->
    io:format("a~n"),
    sem:release(S).

client2(S) ->
    sem:acquire(S),
    io:format("c~n").
