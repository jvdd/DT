/*
vertolk((G1,G2)) :- !,
    vertolk(G1),
    vertolk(G2).
vertolk(true) :- !.
vertolk(Head) :-
    clause(Head,Body),
    vertolk(Body).
*/

% UITBREIDING: TELLEN VAN LOGISCHE INTERFERENTIES
vertolk((G1,G2),Li) :- !,
    vertolk(G1,Li1),
    vertolk(G2,Li2),
    Li is Li1 + Li2.
vertolk(true,0) :- !.
vertolk(Head,Li) :-
    clause(Head, Body), vertolk(Body,LiB),
    Li is LiB + 1.
