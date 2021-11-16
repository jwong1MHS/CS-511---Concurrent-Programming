-module(basic).
-export([mult/2, double/1, distance/2, my_and/2, my_or/2, my_not/1]).
-export([fibonacci/1, fibonacciTR/1]).
-export([sum/1, maximum/1, zip/2, append/2, reverse/1, evenL/1, take/2, drop/2]).
-export([map/2, filter/2, fold/3]).
-export([sumTree/1, mapTree/2, foldTree/3]).
-export([mapGTree/2, foldGTree/2]).

mult(X, Y) ->
    X * Y.

double(X) ->
    2 * X.

distance(X, Y) ->
    math:sqrt((X - Y) * (X - Y)).

my_and(A, B) ->
    if A ->
            if B -> true;
            true -> false
            end;
        true -> false
    end.

my_or(A, B) ->
    if
        A -> true;
        B -> true;
        true -> false
    end.

my_not(A) ->
    if
        A -> false;
        true -> true
    end.

fibonacci(N) ->
    if
        N < 0 -> error;
        N == 0 -> 0;
        N == 1 -> 1;
        N > 1 ->
            fibonacci(N-1) + fibonacci(N-2)
    end.

fibTRHelper(N, A, B) ->
    if
        N == 0 -> A;
        N == 1 -> B;
        true -> fibTRHelper(N-1, B, A + B)
    end.

fibonacciTR(N) when N < 0 -> error;
fibonacciTR(N) -> fibTRHelper(N, 0, 1).

sum([]) -> 0;
sum([H|T])-> H + sum(T).

maximum([]) -> error;
maximum([A]) -> A;
maximum([H | T]) ->
    max_helper(H, T).

max_helper(M, []) -> M;
max_helper(M, [H | T]) when H > M -> max_helper(H, T);
max_helper(M, [H | T]) -> max_helper(M, T).

zip([A | B], [C | D]) -> [{A, C} | zip(B, D)];
zip(_, _) -> [].

append([], L2) -> L2;
append([H | T], L2) -> [H | append(T, L2)].

reverse([]) -> [];
reverse([H | T]) -> reverse(T) ++ [H].

evenL([]) -> [];
evenL([H | T]) when H rem 2 == 0 -> [H] ++ evenL(T);
evenL([_H | T]) -> evenL(T).

take(0, [_H | _T]) -> [];
take(_N, []) -> [];
take(N, [H | T]) when N < 0 -> error;
take(N, [H | T]) -> [H] ++ take(N-1, T).

drop(0, [H | T]) -> [H | T];
drop(_N, []) -> [];
drop(N, [_H | _T]) when N < 0 -> error;
drop(N, [_H | T]) -> drop(N-1, T).

map(_F, []) -> [];
map(F, [H | T]) -> [F(H)] ++ map(F, T).

filter(_C, []) -> [];
filter(C, [H | T]) ->
    case C(H) of 
        true -> [H] ++ filter(C, T);
        false -> filter(C, T)
    end.

fold(_F, A, []) -> A;
fold(F, A, [H | T]) -> fold(F, F(A, H), T).

sumTree({empty}) -> 0;
sumTree({node, X, LT, RT}) -> X + sumTree(LT) + sumTree(RT).

mapTree(_F, {empty}) -> {empty};
mapTree(F, {node, X, LT, RT}) -> {node, F(X), mapTree(F, LT), mapTree(F, RT)}.

foldTree(F, A, {empty}) -> A;
foldTree(F, A, {node, X, LT, RT}) -> F(A, foldTree(F, A, LT), foldTree(F, A, RT)).

mapGTreeHelper(_F, []) -> [];
mapGTreeHelper(F, [H | T]) -> [mapGTree(F, H) | mapGTreeHelper(F, T)].

mapGTree(F, {node, X, L}) -> {node, F(X), mapGTreeHelper(F, L)}.

foldGTreeHelper(F, []) -> [];
foldGTreeHelper(F, [H | T]) -> [foldGTree(F, H) | foldGTreeHelper(F, T)].

foldGTree(F, {node, X, L}) -> F(X, foldGTreeHelper(F, L)).