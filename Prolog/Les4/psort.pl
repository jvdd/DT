psort(L, S) :-
    sorted(S),
    permute(L, S).

sorted1(X, Y, R) :-
    X < Y,
    sorted([Y|R]).

sorted([_]).
sorted([X,Y|T]) :-
    freeze(Y,sorted1(X,Y,T)).

permute([], []).
permute(In, [X|Out]) :-
    delete(X,In,NewIn),
    permute(NewIn,Out).

delete(X, [X|R] ,R).
delete(X, [Y|R], [Y|S]) :-
    delete(X,R,S).
