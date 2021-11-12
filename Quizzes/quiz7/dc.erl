%% Name: Kevin Ha
%% Partner: Jason Wong

-module(dc).
-compile(export_all).
	
start(E,M) ->
    S=spawn(?MODULE,dryCleaner,[0,0]),
    [ spawn(?MODULE,employee,[S]) || _ <- lists:seq(1,E) ],
    [ spawn(?MODULE,dryCleanMachine,[S]) || _ <- lists:seq(1,M) ].
    

dryCleaner(Clean,Dirty) -> %% Clean, Dirty are counters
    receive 
        {dropOffOverall} ->
            %%io:format("Clean: ~w Dirty: ~w~n", [Clean, Dirty]),
            dryCleaner(Clean, Dirty + 1);
        
        {From, dryCleanItem} when Dirty > 0 ->
            From ! {ack},
            %%io:format("Clean: ~w Dirty: ~w~n", [Clean, Dirty]),
            dryCleaner(Clean + 1, Dirty - 1);
            
        {From, pickUpOverall} when Clean > 0 ->
            From ! {ack},
            %%io:format("Clean: ~w Dirty: ~w~n", [Clean, Dirty]),
            dryCleaner(Clean - 1, Dirty)
    end.

employee(DC) -> % drop off overall, then pick up a clean one (if none
                % is available, wait), and end
    DC ! {dropOffOverall},
    DC ! {self(), pickUpOverall},
    receive 
        {ack} ->
            % io:format("Employee picked up overall~n"),
            done
    end.

dryCleanMachine(DC) ->  % dry clean item (if none are available, wait),
                        % then sleep for 1000 milliseconds and repeat
    DC ! {self(), dryCleanItem},
    receive
        {ack} ->
            timer:sleep(1000),
            % io:format("Finished cleaning~n"),
            dryCleanMachine(DC)
    end.



