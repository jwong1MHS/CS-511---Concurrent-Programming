-module(eb8_5).
-compile(export_all).

start(T) ->
    S = spawn(?MODULE,timer_loop,[[]]),
    spawn(?MODULE, timer, [T, S]),
    register_clients(S).

register_clients(S) ->
    [ S ! {register, spawn(?MODULE, client, [])} || _ <- lists:seq(1, 10)],
    ok.

timer(Frequency, S) ->
    timer:sleep(Frequency),
    S!{tick},
    timer(Frequency, S).

timer_loop(L) ->
    receive
        {register, Client} ->
            timer_loop(L ++ [Client]);
        {tick} ->
            [ Pid!{tick} || Pid <- L],
            timer_loop(L)
    end.

client() ->
    receive
        {tick} ->
            client()
    end.
