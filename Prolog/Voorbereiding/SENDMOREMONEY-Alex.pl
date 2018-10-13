
oplossing(S,E,N,D, M,O,R,E, M,O,N,E,Y):-
   freeze(S, S \= 0),
   freeze(M, M \= 0),
   generate([S,M,E,N,D,O,R,Y], [0,1,2,3,4,5,6,7,8,9]),
   splits(D + E, Y, Rest1),
   splits(N + R + Rest1, E, Rest2),
   splits(E + O + Rest2, N, Rest3),
   splits(S + M + Rest3, O, M).

generate([], _).
generate([X|Xs], L):-
   select(X, L, NewL),
   generate(Xs, NewL).

splits(X, Res, Rest):-
   Res is X mod 10,
   Rest is X // 10.
