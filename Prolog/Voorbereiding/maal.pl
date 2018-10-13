% Versie met X en Y opvolgersfuncties
maal(X, Y, Prod) :-
    maal(X, X, Y, Prod).

maal(_, X, s(nul), X) :- !.
maal(OrigX, X, s(Y), Prod) :-
    plus_dt(X, OrigX, Som),
    maal(OrigX, Som, Y, Prod).

% Zodat de plusfunctie er zeker is
plus_dt(X, nul, X) :- !.
plus_dt(X, s(Y), Som) :-
    plus_dt(s(X), Y, Som).
