listlength([],0).
listlength([_|Rest],Len) :-
    listlength(Rest,LenRest),
    Len is LenRest + 1.
