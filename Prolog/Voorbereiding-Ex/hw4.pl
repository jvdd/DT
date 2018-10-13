
% DATA: ['C:/Users/Jeroen/Documents/Prolog/HW4/wegennet1.pl'].

besteweg(Start,Aankomst,DagLimiet,Traject,Hotel) :-
    vindAlleSteden(Steden),

    dijkstra(Steden, Start, Aankomst, Traject, Kost).

vindAlleSteden(Steden) :-
    findall(Stad, afstand(Stad,_,_), S1),
    findall(Stad, afstand(_,Stad,_), S2),
    append(S1,S2,UnsortedSteden),
    sort(UnsortedSteden,Steden).

dijkstra(Steden, Start, Aankomst, Traject, Kost) :-
    initialisatie(Steden,Start,T,L),
    voerAlgoUit(T,L,[],Start,Aankomst,Traject,Kost). % I = []

initialisatie(Steden,Start,T,L) :-
    T = Steden,
    findall((nan,Stad),(member(Stad,Steden),Stad \= Start),L1),
    L = [(0,Start)|L1].

voerAlgoUit(T,L,I,Start,Aankomst,Traject,Kost) :-
    kiesVolgende(T,L,(V,Vw)),
    delete(T,V,NewT),
    herberekenL(T,L,I,(V,Vw),NewL,NewI),
    (\+ member(Aankomst,NewT) ->
        reconstrueerPad(Start,Aankomst,I,Pad,Kost),
        Traject = [Aankomst|Pad]
    ;
        sort(NewL,NewSortedL),
        voerAlgoUit(NewT,NewSortedL,NewI,Start,Aankomst,Traject,Kost)
    ).

kiesVolgende(T,[(Vw,V)|_],(V,Vw)) :- member(V,T),!.
kiesVolgende(T,[_|Lrest],X) :- kiesVolgende(T,Lrest,X).

herberekenL(T,L,I,(V,Vw),NewL,NewI) :-
    vindAlleBuren(T,V,Buren),
    updateL(Buren,(V,Vw),L,NewL,I,NewI).

vindAlleBuren(T,V,Buren) :-
    findall(Buur, ((afstand(V,Buur,_);afstand(Buur,V,_)),member(Buur,T)),Buren).

updateL([],_,Acc1,Acc1,Acc2,Acc2).
updateL([Stad|Rest],(V,Vw),L,NewL,I,NewI) :-
    (afstand(Stad,V,W);afstand(V,Stad,W)),
    member((LOrig,Stad),L),
    LNew is Vw + W,
    (LNew < LOrig ->
        delete(L,(_,Stad),L1),
        L2 = [(LNew,Stad)|L1],
        (member((_,Stad),I) ->
            delete(I,(_,Stad),I1),
            I2 = [(V,Stad)|I1]
        ;
            I2 = [(V,Stad)|I]
        ),
        updateL(Rest,(V,Vw),L2,NewL,I2,NewI)
    ;
        updateL(Rest,(V,Vw),L,NewL,I,NewI)
    ).

reconstrueerPad(Start,Start,_,[],0).
reconstrueerPad(Start,Aankomst,I,[Voorganger|Pad],Kost) :-
    member((Voorganger,Aankomst),I),
    (afstand(Voorganger,Aankomst,W);afstand(Aankomst,Voorganger,W)),
    reconstrueerPad(Start,Voorganger,I,Pad,RW),
    Kost is W + RW.
