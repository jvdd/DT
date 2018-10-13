:- use_module(library(clpfd)).

vind_kleuring(KleurLijst) :-
    findall(X, knoop(X,_), AlleKnopen),
    vind_alle_kleuren(AlleKleuren),
    vind_kleuring(AlleKnopen, AlleKleuren, KleurLijst).

vind_kleuring(AlleKnopen, AlleKleuren, KleurLijst) :-
    Vars = [A,B],
    Vars = AlleKleuren,
    all_different(Vars),
    checkValid(Vars, AlleKleuren),
    KleurLijst = Vars.

vind_alle_kleuren(AlleKleuren) :-
    findall(X, knoop(_,X), AlleKleurenLijst),
    concatenateSubLists(AlleKleurenLijst, [], AlleKleuren).

concatenateSubLists([], Lijst, AlleKleuren) :- sort(Lijst, AlleKleuren), !.
concatenateSubLists([SubList|Rest], Acc, AlleKleuren) :-
    append(SubList, Acc, NewAcc),
    concatenateSubLists(Rest, NewAcc, AlleKleuren).

checkValid([], _) :- !.
checkValid([Var|Rest], Kleuren) :-
    select(Var, Kleuren, NieuweKleuren),
    checkValid(Rest, NieuweKleuren).
