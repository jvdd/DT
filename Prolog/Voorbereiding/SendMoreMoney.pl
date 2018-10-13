send([S,E,N,D] + [M,O,R,E] = [M,O,N,E,Y]) :-
    freeze(M, M \= 0),
    freeze(S, S \= 0),
    Getallen = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
    Variabelen = [S, E, N, D, M, O, R, Y],
    match(Variabelen, Getallen),
    checkSom([S,E,N,D] + [M,O,R,E] = [M,O,N,E,Y], 0).

match([], _).
match([X|Rest], Getallen) :-
    member(X, Getallen),
    select(X, Getallen, NewGetallen),
    match(Rest, NewGetallen).

checkSom([] + [] = L3, Overdracht) :- L3 = Overdracht.
checkSom(L1 + L2 = L3, Overdracht) :-
    last(L1, X1),
    last(L2, X2),
    last(L3, X3),
    LSom is X1 + X2 + Overdracht,
    LVal is LSom mod 10,
    LVal == X3,
    NewOverdracht is LSom // 10,
    select(X1, L1, NewL1),
    select(X2, L2, NewL2),
    select(X3, L3, NewL3),
    checkSom(NewL1 + NewL2 = NewL3, NewOverdracht).
