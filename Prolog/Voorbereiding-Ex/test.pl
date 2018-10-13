genList(0,Acc,Acc).
genList(X,Acc,Res) :-
    Y is X - 1,
    genList(Y,[X|Acc],Res).
% OMGEKEERDE LIJST ALS RESULTAAT

genList2(0,Acc,Acc).
genList2(X,[X|Acc],Res) :-
    Y is X - 1,
    genList2(Y,Acc,Res).
% FALSE

genList3(0,[]) :- !.
genList3(X,[X|Acc]) :-
    Y is X - 1,
    genList3(Y,Acc).
% LIJST IN JUISTE VOLGORDE ALS RESULTAAT
