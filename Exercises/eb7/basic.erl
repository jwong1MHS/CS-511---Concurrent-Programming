-module(basic).
-import(math,[pow/2,sqrt/1]).
-export([mult/2, double/1, distance/2, my_and/2, my_or/2, my_not/1]).
-export([fibonacci/1, fibonacciTR/1]).
-export([sum/1, maximum/1, zip/2, append/2, reverse/1, evenL/1, take/2, drop/2]).
-export([map/2, filter/2, fold/3]).
-export([sumTree/1, mapTree/2, foldTree/3]).
-export([mapGTree/2,foldGTree/2]).
-export([aTree/0,gTree/0]).

%% Exercise 5 %%
mult(X,Y) -> X*Y.

double(X) -> 2*X.

distance({X1,Y1},{X2,Y2}) -> sqrt(pow((X1+X2),2) + pow((Y1+Y2),2)).

my_and(X,Y) ->
    if
        X ->
            if
                Y -> true;
                true -> false
            end;  
        true -> false
    end.

my_or(X,Y) ->
    if
        X -> true;
        Y -> true;
        true -> false
    end.

my_not(X) ->
    if
        X -> false;
        true -> true
    end.


%% Exercise 6 %%
fibonacci(N) when N < 0 -> error;
fibonacci(N) when N == 0 -> 0;
fibonacci(N) when N == 1 -> 1;
fibonacci(N) -> fibonacci(N-1) + fibonacci(N-2).

fibonacciTRhelper(N,_A,_B) when N < 0 -> error;
fibonacciTRhelper(N,A,_B) when N == 0 -> A;
fibonacciTRhelper(N,_A,B) when N == 1 -> B;
fibonacciTRhelper(N,A,B) -> fibonacciTRhelper(N-1,B,A+B).
fibonacciTR(N) -> fibonacciTRhelper(N,0,1).


%% Exercise 7 %%
sum([]) -> 0;
sum([H | T]) -> H + sum(T).

maximumhelper(N, []) -> N;
maximumhelper(N, [H | T]) when N < H -> maximumhelper(H, T);
maximumhelper(N, [_H | T]) -> maximumhelper(N, T).
maximum([]) -> [];
maximum(L) -> maximumhelper(0, L).

zip([], []) -> [];
zip(L1, L2) when length(L1) /= length(L2) -> error;
zip([H1 | T1], [H2 | T2]) -> [{H1, H2} | zip(T1, T2)].

append([], L) -> L;
append([H1 | T1], L) -> [H1 | append(T1, L)].

reverse([]) -> [];
reverse([H | T]) -> reverse(T) ++ [H].

evenL([]) -> [];
evenL([H | T]) when (H rem 2 == 0) -> [H | evenL(T)];
evenL([_H | T]) -> evenL(T).

take(_,[]) -> [];
take(N,[H | T]) when (N < 0) or (N > length([H | T])) -> error;
take(N,[_H | _T]) when N == 0 -> [];
take(N,[H | T]) -> [H | take(N-1,T)].

drop(_N,[]) -> [];
drop(N,[H | T]) when (N < 0) or (N > length([H | T])) -> error;
drop(N,[H | T]) when N == 0 -> [H | T];
drop(N,[_H | T]) -> drop(N-1,T).


%% Exercise 9 %%
map(_F,[]) -> [];
map(F,[H | T]) -> [F(H)] ++ map(F,T).

filter(_F,[]) -> [];
filter(F,[H | T]) ->
    case F(H) of
        true -> [H | filter(F,T)];
        false -> filter(F,T)
    end.

fold(_F,A,[]) -> A;
fold(F,A,[H | T]) -> F(H,fold(F,A,T)).


aTree() ->
    {node,20,
         {node,4,{empty},{empty}},
         {node,77,
	         {node,33,{empty},{empty}},
                 {empty}}}.

gTree() ->
    {node,20,
        [{node,4,
            []
         },
         {node,77,
	        [{node,33,[]}]
         }
        ]
    }.

%% Exercise 10 %%
sumTreehelper([]) -> 0;
sumTreehelper([{empty} | T]) -> sumTreehelper(T);
sumTreehelper([{node,Number,LSubtree,RSubtree} | T]) ->
    Number + sumTreehelper([LSubtree] ++ [RSubtree] ++ T).
sumTree({empty}) -> 0;
sumTree({node,Number,LSubtree,RSubtree}) ->
    Number + sumTreehelper([LSubtree,RSubtree]).

mapTree(_F,{empty}) -> {empty};
mapTree(F,{node,Number,LSubtree,RSubtree}) ->
    {node,F(Number),mapTree(F,LSubtree),mapTree(F,RSubtree)}.

foldTree(_F,A,{empty}) -> A;
foldTree(F,A,{node,Number,LSubtree,RSubtree}) ->
    F(Number,foldTree(F,A,LSubtree),foldTree(F,A,RSubtree)).


%% Exercise 11 %%
mapGTreeHelper(_F, []) -> [];
mapGTreeHelper(F, [H | T]) -> [mapGTree(F, H) | mapGTreeHelper(F, T)].
mapGTree(F, {node, X, L}) -> {node, F(X), mapGTreeHelper(F, L)}.

foldGTreeHelper(_F, []) -> [];
foldGTreeHelper(F, [H | T]) -> [foldGTree(F, H) | foldGTreeHelper(F, T)].
foldGTree(F, {node, X, L}) -> F(X, foldGTreeHelper(F, L)).