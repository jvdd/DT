% In deze oplossing wordt er gebruik gemaakt van het algoritme van Dijkstra

% DYNAMIC DECLARATIE VAN LABEL EN VOORGANGER
dynamic label/2.
dynamic voorganger/2.

beste_weg(Start, Bestemming, Daglimiet, Traject, Hotel) :-
    retractall(label(_,_)),
    retractall(voorganger(_,_)),
    initialisatie(Start, NogNietBehandeld),
    dijkstra(Start, Bestemming, Daglimiet, NogNietBehandeld),
    (
    label(Afstand,Bestemming), Afstand =< Daglimiet ->
        Hotel = geen,
        reconstrueerPad(Start, Bestemming, Traject)
    ;
        vindBesteHotel(Start, Bestemming, Daglimiet, Hotel),
        retractall(label(_,_)),
        initialisatie(Start, NogNietBehandeld1),
        retractall(voorganger(_,_)),
        dijkstra(Start, Hotel, Daglimiet, NogNietBehandeld1),
        reconstrueerPad(Start, Hotel, Traject1),
        retractall(label(_,_)),
        initialisatie(Hotel, NogNietBehandeld2),
        retractall(voorganger(_,_)),
        dijkstra(Hotel, Bestemming, Daglimiet, NogNietBehandeld2),
        reconstrueerPad(Hotel, Bestemming, Traject2),
        delete(Hotel,Traject2, Traject2ZonderHotel), % Anders zit hotel dubbel in traject
        append(Traject1, Traject2ZonderHotel, Traject)
    ).


dijkstra(Start, Bestemming, Daglimiet, NogNietBehandeld) :-
    (
    member(Bestemming,NogNietBehandeld) ->
        kies_volgende(NogNietBehandeld,VolgendeStad),
        delete(VolgendeStad, NogNietBehandeld, UpdatedNogNietBehandeld),
        hebereken_labels(VolgendeStad, UpdatedNogNietBehandeld),
        dijkstra(Start, Bestemming, Daglimiet, UpdatedNogNietBehandeld)
    ;
        !
    ).

initialisatie(Start, NogNietBehandeld) :-
    asserta(label(0, Start)),
    findall(X,afstand(X,_,_), Linkersteden),
    findall(Y,afstand(_,Y,_), RechterSteden),
    append(Linkersteden,RechterSteden, NogNietBehandeldUnsorted),
    sort(NogNietBehandeldUnsorted, NogNietBehandeld), % Om zo dubbele waarden te vermijden
    initLabel(Start,NogNietBehandeld).

initLabel(_,[]) :- !.
initLabel(Start,[Stad|Rest]) :-
    (
    Stad \= Start ->
        assertz(label(inf,Stad)),
        initLabel(Start,Rest)
    ;
        initLabel(Start,Rest)
    ).

kies_volgende(NogNietBehandeld, VolgendeStad) :-
    findall((Label, Stad), (member(Stad, NogNietBehandeld), label(Label,Stad)), LabelNogNietBehandeldeSteden),
    sort(LabelNogNietBehandeldeSteden, [(_,VolgendeStad)|_]).

hebereken_labels(_, []) :- !.
hebereken_labels(VolgendeStad, [Stad|Rest]) :-
    (
    (afstand(VolgendeStad, Stad, Afstand) ; afstand(Stad, VolgendeStad, Afstand)) ->
        label(X, VolgendeStad),
        label(Y, Stad),
        (X \= inf ->
            PadViaVolgendeStad is X + Afstand
        ;
            PadViaVolgendeStad = inf
        ),
        (
        Y > PadViaVolgendeStad ->
            retract(label(Y,Stad)),
            assertz(label(PadViaVolgendeStad,Stad)),
            asserta(voorganger(Stad,VolgendeStad)),
            hebereken_labels(VolgendeStad,Rest)
        ;
            hebereken_labels(VolgendeStad,Rest)
        )
    ;
        hebereken_labels(VolgendeStad, Rest)
    ).

reconstrueerPad(Start, Bestemming, Traject) :-
    reconstrueerPad(Start, Bestemming, [Bestemming], Traject).

reconstrueerPad(Start, Start, AccOpvolgers, AccOpvolgers) :- !.
reconstrueerPad(Start, Stad, AccOpvolgers, Traject) :-
    voorganger(Stad, Voorganger),
    reconstrueerPad(Start, Voorganger, [Voorganger|AccOpvolgers], Traject).

vindBesteHotel(Start, Bestemming, Daglimiet, Hotel) :-
    vindAlleHotels(HotelLijst),
    vindBesteHotel(Start, Bestemming, Daglimiet, HotelLijst, [], BesteHotels),
    sort(BesteHotels, [(_,Hotel)|_]).

vindBesteHotel(_, _, _, [], AccLijst, AccLijst) :- !.
vindBesteHotel(Start, Bestemming, Daglimiet, [Hotel|Rest], AccLijst, BesteHotels) :-
    retractall(label(_,_)),
    initialisatie(Start, NogNietBehandeld1),
    retractall(voorganger(_,_)), % Verwijdert alle predicaten van voorganger
    dijkstra(Start, Hotel, Daglimiet, NogNietBehandeld1),
    label(Afstand1, Hotel),
    retractall(label(_,_)),
    initialisatie(Hotel, NogNietBehandeld2),
    retractall(voorganger(_,_)),
    dijkstra(Hotel, Bestemming, Daglimiet, NogNietBehandeld2),
    label(Afstand2, Bestemming),
    (Afstand1 =< Daglimiet, Afstand2 =< Daglimiet ->
        TotAfstand is Afstand1 + Afstand2,
        vindBesteHotel(Start, Bestemming, Daglimiet, Rest, [(TotAfstand,Hotel)|AccLijst], BesteHotels)
    ;
        vindBesteHotel(Start, Bestemming, Daglimiet, Rest, AccLijst, BesteHotels)
    ).

vindAlleHotels(HotelLijst):-
    findall(X,hotel(X),HotelLijst).

delete(X, [X|R] ,R).
delete(X, [Y|R], [Y|S]) :-
    delete(X,R,S).
