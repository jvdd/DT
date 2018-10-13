appendList([],L,L).
appendList([X | Rest],T,[X | ARest]) :-
    appendList(Rest,T,ARest).
