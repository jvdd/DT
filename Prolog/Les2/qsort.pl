qsort([],[]).
qsort([Spil|Rest],Sorted) :-
    split(Spil,Rest,Kleiner,Groter),
    qsort(Kleiner,KS),
    qsort(Groter,GS),
    appendList(KS,[Spil|GS],Sorted).

split(_,[],[],[]).
split(Spil,[X|R],Kleiner,Groter) :-
    Spil > X, Kleiner = [X|RestK],
    split(Spil,R,RestK,Groter).
split(Spil,[X|R],Kleiner,Groter) :-
    Spil =< X, Groter = [X|RestG],
    split(Spil,R,Kleiner,RestG).


    % Zodat dit ook zeker mee wordt gecompileerd
appendList([],L,L).
appendList([X | Rest],T,[X | ARest]) :-
    appendList(Rest,T,ARest).
