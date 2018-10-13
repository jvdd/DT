psort(L,S) :-
    permute(L,S),
    sorted(S).

sorted([]).
sorted([_]).
sorted([X,Y|R]) :-
    X < Y,
    sorted([Y|R]).

permute([],[]).
permute([X|R],P) :-
    permute(R,RP),
    deleteList(X,P,RP). % Insert

% Zodat dit ook zeker mee wordt gecompileerd
deleteList(X,[X | R],R).
deleteList(X,[Y | R], [Y | S]) :-
    deleteList(X,R,S).
