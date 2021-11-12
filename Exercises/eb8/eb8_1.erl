-module(eb8_1).
-compile(export_all).

start(N) -> %% Spawns a counter and N turnstile clients
    C = spawn(?MODULE,counter_server,[0]),
    [ spawn(?MODULE,turnstile,[C,50]) || _ <- lists:seq(1,N)] ,
    C.

counter_server(State) -> %% State is the current value of the counter
    receive
        {bump} ->
            counter_server(State + 1);
        {read, From} ->                                                                                                                                                
            From!{State},
            counter_server(State)
    end.

turnstile(C,0) ->
    done;
turnstile(C,N) -> %% C is the PID of the counter , and N the number of
    C!{bump}, %% times the turnstile turns
    turnstile(C,N-1).

%% c(ex1).
%% ex1:start(4).
%% C = list_to_pid("<0.63.0>").
%% C.