sublist1(L1,L2) :-
    appendList(A,_,L2),
    appendList(_,L1,A).

sublist2(L1,L2) :-
    appendList(_,L1,A),
    appendList(A,_,L2).

% Zodat dit ook zeker mee wordt gecompileerd
appendList([],L,L).
appendList([X | Rest],T,[X | ARest]) :-
    appendList(Rest,T,ARest).
