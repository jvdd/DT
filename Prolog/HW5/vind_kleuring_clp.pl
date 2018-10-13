:- use_module(library(clpfd)).


% TESTDATA

knoop(b,[2,4,6]).
knoop(a,[5,1,3]).
knoop(c,[1,2]).
knoop(d,[1,3]).

boog(a, b).
boog(b, c).
boog(a, c).
boog(c, d).
boog(d, a).



% OPDRACHT 1

vind_kleuring(KleurLijst) :-
    findall(X, knoop(X, _), AlleKnopen),
    length(AlleKnopen, L),
    length(Kleuren, L),
    kleuringConstraint(AlleKnopen, Kleuren),
    initKleurLijst(AlleKnopen, Kleuren, KleurLijst).

kleuringConstraint(AlleKnopen, Kleuren) :-
    vindMinMaxKleur(Min, Max),
    Kleuren ins Min..Max,
    kleurConstraint(AlleKnopen, Kleuren),
    burenConstraint(AlleKnopen, Kleuren),
    label(Kleuren).

vindMinMaxKleur(Min, Max) :-
    vind_alle_kleuren([Min|Rest]),
    max_lijst([Min|Rest], Max). % Voor moest er in totaal 1 kleur zijn

vind_alle_kleuren(AlleKleuren) :-
    findall(X, knoop(_,X), AlleKleurenLijst),
    concatenateSubLists(AlleKleurenLijst, [], AlleKleuren).

concatenateSubLists([], Lijst, AlleKleuren) :- sort(Lijst, AlleKleuren).
concatenateSubLists([SubList|Rest], Acc, AlleKleuren) :-
    append(SubList, Acc, NewAcc),
    concatenateSubLists(Rest, NewAcc, AlleKleuren).

max_lijst([Max|[]], Max).
max_lijst([_|Rest], Max) :-
    max_lijst(Rest, Max).

kleurConstraint([], []).
kleurConstraint([Knoop|Rest1], [Kleur|Rest2]):-
    knoop(Knoop, AanvKleuren),
    getDomain(AanvKleuren, Dom),
    Kleur in Dom,
    kleurConstraint(Rest1, Rest2).

getDomain([Kleur|Rest], Dom) :-
    getDomain(Rest, Kleur, Dom).

getDomain([], Dom, Dom).
getDomain([Kleur|Rest], Acc, Dom) :-
    getDomain(Rest, Kleur \/ Acc, Dom).

burenConstraint(AlleKnopen, Kleuren) :-
    burenConstraint(AlleKnopen, Kleuren, AlleKnopen, Kleuren).

burenConstraint(_, _, [], []).
burenConstraint(AlleKnopen, Kleuren, [Knoop|Rest1], [Kleur|Rest2]) :-
    vind_alle_buren(Knoop, Buren),
    kleuren_bij_knopen(Buren, AlleKnopen, Kleuren, BuurKleuren),
    checkBuren(Kleur, BuurKleuren),
    burenConstraint(AlleKnopen, Kleuren, Rest1, Rest2).

vind_alle_buren(Knoop, AlleBuren) :-
    findall(X, boog(X, Knoop), Buren1),
    findall(Y, boog(Knoop, Y), Buren2),
    append(Buren1, Buren2, AlleBurenUnsorted),
    sort(AlleBurenUnsorted, AlleBuren). % Om er zo dubbele waarden uit te halen

kleuren_bij_knopen(Buren, AlleKnopen, L, Kleuren) :-
    kleuren_bij_knopen(Buren, AlleKnopen, AlleKnopen, L, L, [], Kleuren).

kleuren_bij_knopen([], _, _, _, _, BuurKleuren, BuurKleuren).
kleuren_bij_knopen([Buur|Rest1], [Knoop|Rest2], AlleKnopen, [Kleur|Rest3], Kleuren, Acc, BuurKleuren) :-
    (Buur == Knoop ->
        kleuren_bij_knopen(Rest1, AlleKnopen, AlleKnopen, Kleuren, Kleuren, [Kleur|Acc], BuurKleuren)
    ;
        kleuren_bij_knopen([Buur|Rest1], Rest2, AlleKnopen, Rest3, Kleuren, Acc, BuurKleuren)
    ).

checkBuren(_, []).
checkBuren(Kleur, [BuurKleur|Rest]) :-
    all_different([Kleur|[BuurKleur]]),
    checkBuren(Kleur, Rest).

initKleurLijst(AlleKnopen, Kleuren, KleurLijst) :-
    initKleurLijst(AlleKnopen, Kleuren, [], KleurLijst).

initKleurLijst([], [], Lijst, KleurLijst) :- sort(Lijst, KleurLijst). % Zodat mooi alfabetisch weergeven wordt
initKleurLijst([Knoop|Rest1], [Kleur|Rest2], Acc, KleurLijst) :-
    initKleurLijst(Rest1, Rest2, [kleur(Knoop, Kleur)|Acc], KleurLijst).




% OPDRACHT 2

vind_min_kleuring(KleurLijst) :-
    findall(X, knoop(X, _), AlleKnopen),
    length(AlleKnopen, L),
    length(Kleuren, L),
    minKleuringConstraint(AlleKnopen, Kleuren),
    initKleurLijst(AlleKnopen, Kleuren, KleurLijst).

minKleuringConstraint(AlleKnopen, Kleuren) :-
    vindMinMaxKleur(Min, Max),
    Kleuren ins Min..Max,
    kleurConstraint(AlleKnopen, Kleuren),
    burenConstraint(AlleKnopen, Kleuren),
    bepaalMaxInit(Kleuren, MaxKleur),
    labeling([min(MaxKleur)], Kleuren),
    !. % Er wordt 1 minimale kleurig terug gegeven

bepaalMaxInit([Kleur|Rest], Max) :-
    bepaalMax(Rest, Kleur, Max).

bepaalMax([], Acc, Max) :- Max #= Acc.
bepaalMax([Kleur|Rest], Acc, Max) :-
    (Kleur #=< Acc ->
        bepaalMax(Rest, Acc, Max)
    ;
        bepaalMax(Rest, Kleur, Max)
    ).

/*
FOUT: Ik dacht dat het minimale som moest zijn
bepaalSom([Kleur|Rest], Som) :-
    bepaalSom(Rest, -10000 , Som).

bepaalSom([], Acc, Som) :- Som #= Acc.
bepaalSom([Kleur|Rest], Acc, Som) :-
    ()
    bepaalSom(Rest, Kleur + Acc, Som).
*/
