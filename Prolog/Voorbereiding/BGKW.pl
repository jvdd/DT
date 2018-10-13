oplossing(Stappen) :-
    begin(Start),
    volgendeStap(Start, Stap),
    vindOplossing(Stap, [Start], Stappen).

begin((links, [g, k, w])).
einde((rechts, [g, k, w])).

vindOplossing(_, [Einde|Rest], Stappen) :-
    einde(Einde),
    Stappen = [Einde|Rest].
vindOplossing(Stap, [Vorige|Acc], Stappen) :-
    %write([Vorige|Acc]), nl, write(Stap), nl, nl, % TODO
    checkOk(Stap, Vorige),
    \+ member(Stap, Acc),
    volgendeStap(Stap, NieuweStap),
    vindOplossing(NieuweStap, [Stap|[Vorige|Acc]], Stappen).

checkOk((_, NewLijst), (Loc, Lijst)) :-
    (
        begin(Stap),
        Stap == (Loc, Lijst)
    ;
        (
            \+ (
                member(g, Lijst),
                member(k, Lijst),
                (
                    \+ member(g, NewLijst)
                ,
                    \+ member(k, NewLijst)
                )
            ),
            \+ (
                member(w, Lijst),
                member(g, Lijst),
                (
                    \+ member(w, NewLijst)
                ,
                    \+ member(g, NewLijst)
                )
            )
        )
    ).

volgendeStap((Locatie, Lijst), NieuweStap) :-
    (Locatie == links ->
        NewLocatie = rechts
    ;
        NewLocatie = links
    ),
    deleteSL(Lijst, [g, k, w], OpOever),
    (
        (
            member(X, Lijst),
            NewOever = [X|OpOever]
        )
    ;
        NewOever = OpOever
    ),
    sort(NewOever, Oever),
    NieuweStap = (NewLocatie, Oever).

deleteSL([], LijstZonderSL, LijstZonderSL).
deleteSL([X|Rest], Lijst, LijstZonderSL) :-
    select(X, Lijst, NewLijst),
    deleteSL(Rest, NewLijst, LijstZonderSL).
