-module(barr).
-compile(export_all).




start(N) ->
    B = spawn(?MODULE,loop,[N,N,[]]),
    spawn(?MODULE,client1,[B]),
    spawn(?MODULE,client2,[B]).


% loop(N,M,L) 
% the main loop for a barrier of size N
% M are the number of threads yet to reach the barrier
% L is the list of PID,Ref of the threads that have already reached the barrier

notify([]) ->
    ok;
notify([ {Pid,Ref} | T]) ->
    Pid!{ok,Ref},
    notify(T).

loop(N,0,L) ->
    % [ Pid!{ok,Ref} || {Pid,Ref} <- L],
    notify(L),
    loop(N,N,[]);

loop(N,M,L) ->
    receive
        {From, Ref} ->
            loop(N,M-1,[{From,Ref} | L])
    end.

reached(B) ->
    R = make_ref(),
    B!{self(),R},
    receive
        {ok,R} ->
	    ok
    end.
     

client1(B) ->
    io:format("a~n"),
    reached(B),
    io:format("1~n").

client2(B) ->
    io:format("b~n"),
    reached(B),
    io:format("2~n").
    



