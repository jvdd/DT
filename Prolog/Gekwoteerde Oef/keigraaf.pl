% OPDRACHT 2: keigraaf/2


% TESTDATA
/*
boog(a, b).
boog(b, c).
boog(a, c).

heeftkeien(a, 5).
heeftkeien(b, 3).
heeftkeien(c, 2).
*/

boog(a,b).
boog(a,c).
boog(a,d).
boog(a,e).
boog(a,f).
boog(a,g).
boog(a,h).
boog(a,i).

heeftkeien(a,4).
heeftkeien(b,0).
heeftkeien(c,0).
heeftkeien(d,0).
heeftkeien(e,0).
heeftkeien(f,0).
heeftkeien(g,0).
heeftkeien(h,0).
heeftkeien(i,0).

herhalend(Configuratie, Lengte) :-
    vindAlleKnopen(AlleKnopen),
    initConfiguratie(AlleKnopen, InitConfiguratie),
    sort(InitConfiguratie, SortedInitConfiguratie),
    vindPeriode(AlleKnopen, [SortedInitConfiguratie], Configuratie, Lengte).

vindAlleKnopen(AlleKnopen) :-
    findall(Knoop, heeftkeien(Knoop, _), AlleKnopen).

initConfiguratie([], []) :- !.
initConfiguratie([Knoop|Rest], [(Knoop, AantalKeien)|RestLijst]) :-
    heeftkeien(Knoop, AantalKeien),
    initConfiguratie(Rest, RestLijst).

vindPeriode(AlleKnopen, [VorigeConfiguratie|Acc], Herhaling, Lengte) :-
    initVolgendeKeiGraaf(AlleKnopen, InitVolgendeKeiGraaf),
    volgendeKeiGraaf(AlleKnopen, VorigeConfiguratie, InitVolgendeKeiGraaf, VolgendeConfiguratie),
    sort(VolgendeConfiguratie, SortedVolgendeConfiguratie),
    (member(SortedVolgendeConfiguratie, [VorigeConfiguratie|Acc]) ->
        Herhaling = SortedVolgendeConfiguratie,
        vindLengte(Herhaling, Acc, Lengte)
    ;
        vindPeriode(AlleKnopen, [SortedVolgendeConfiguratie|[VorigeConfiguratie|Acc]], Herhaling, Lengte)
    ).

initVolgendeKeiGraaf([], []) :- !.
initVolgendeKeiGraaf([Knoop|Rest], [(Knoop, 0)|RestLijst]) :-
    heeftkeien(Knoop, _),
    initVolgendeKeiGraaf(Rest, RestLijst).

volgendeKeiGraaf([], _, VolgendeConfiguratie, VolgendeConfiguratie) :- !.
volgendeKeiGraaf([Knoop|Rest], Configuratie, Acc, VolgendeConfiguratie) :-
    vindAlleBuren(Knoop, AlleBuren),
    length(AlleBuren, AantalBuren),
    aantalKeienInConfiguratie(Knoop, Configuratie, AantalKeien),
    VerdeelAantal is AantalKeien // AantalBuren,
    NietVerdeeldAantal is AantalKeien mod AantalBuren,
    updateConfiguratie(Knoop, VerdeelAantal, NietVerdeeldAantal, Acc, UpdatedAcc),
    volgendeKeiGraaf(Rest, Configuratie, UpdatedAcc, VolgendeConfiguratie).

vindAlleBuren(Knoop, AlleBuren) :-
    findall(X, (boog(Knoop,X); boog(X, Knoop)), AlleburenUnsorted),
    sort(AlleburenUnsorted, AlleBuren). % Dubbele waarden vermijden

aantalKeienInConfiguratie(Knoop, [(Knoop,AantalKeien)|_], AantalKeien) :- !.
aantalKeienInConfiguratie(Knoop, [_|Rest], AantalKeien) :-
    aantalKeienInConfiguratie(Knoop, Rest, AantalKeien).

% TODO: Hier controleer ik niet of de AndereKnoop knoop wel een buur is
updateConfiguratie(_, _, _, [], []) :- !.
updateConfiguratie(Knoop, VerdeelAantal, NietVerdeeldAantal, [(Knoop, Aantal)|Rest1], [(Knoop, NieuwAantal)|Rest2]) :-
    !,
    NieuwAantal is Aantal + NietVerdeeldAantal,
    updateConfiguratie(Knoop, VerdeelAantal, NietVerdeeldAantal, Rest1, Rest2).
updateConfiguratie(Knoop, VerdeelAantal, NietVerdeeldAantal, [(AndereKnoop, Aantal)|Rest1], [(AndereKnoop, NieuwAantal)|Rest2]) :-
    NieuwAantal is Aantal + VerdeelAantal,
    updateConfiguratie(Knoop, VerdeelAantal, NietVerdeeldAantal, Rest1, Rest2).

vindLengte(Herhaling, VorigeKeigrafenLijst, Lengte) :-
    reverse(VorigeKeigrafenLijst, RevVorigeKeigrafenLijst),
    vindLengte(Herhaling, RevVorigeKeigrafenLijst, 1, Lengte).

vindLengte(Herhaling, [Herhaling|_], Lengte, Lengte) :- !.
vindLengte(Herhaling, [_|Rest], Acc, Lengte) :-
    NewAcc is Acc + 1,
    vindLengte(Herhaling, Rest, NewAcc, Lengte).
