-module(sem).
-compile(export_all).


start_sem(Init) ->
    spawn(?MODULE,sem_loop,[Init]).

sem_loop(0) ->
    receive
        {release} ->
            sem_loop(1)
    end;
sem_loop(P) when P>0 ->
    receive
        {release} ->
            sem_loop(P+1);
        {acquire,From} ->
            From!{ack},
            sem_loop(P-1)
    end.

acquire(S) ->
    S!{acquire,self()},
    receive
        {ack} ->
            done
    end.

release(S) ->
    S!{release}.
