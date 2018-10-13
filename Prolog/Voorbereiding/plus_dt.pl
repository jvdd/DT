% Versie 1: Y is een getal
/*
plus_dt(X, 0, X):- !.
plus_dt(X, Y, Som) :-
    NewY is Y - 1,
    plus_dt(s(X), NewY, Som).
*/

% Versie 2: Y is ook gediefineerd met opvolgersfunctie
plus_dt(X, nul, X) :- !.
plus_dt(X, s(Y), Som) :-
    plus_dt(s(X), Y, Som).
