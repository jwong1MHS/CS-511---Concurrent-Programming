-module(fs).
-compile(export_all).


fact(0) ->
    1;
fact(N) when N>0 ->
    N*fact(N-1).

loop(C) ->
    receive
		{req,Ref,From,N} ->
			From!{Ref,fact(N)},
			loop(C+1);
		{stat,From} ->
			From!C,
			loop(C);
		stop ->
			stop
	end.

start() ->
    S = spawn(?MODULE,loop,[0]),
    S.
