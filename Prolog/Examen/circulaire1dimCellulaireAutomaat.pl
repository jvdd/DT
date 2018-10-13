/*  EXAMEN DT 20/06/2017
  @Author Jeroen Van Der Donckt
*/

%%%% Vraag 1

volgende_generatie(Autom,Getal,Out) :-
    toBinairLijst(Getal,BinLijst),
    length(Autom,L),
    maakBinLijstLengteT(BinLijst,8,KleurLijst), % Nullen vanvoor toevoegen indien nodig
    initTLijst(KleurLijst,Tlijst),
    genereerVolgende(Autom,L,Tlijst,Volgende), % Volgende is omgekeerde binaire versie van Out
    constructOut(Volgende,Out).

toBinairLijst(X,BinLijst) :-
    toBinairLijstAcc(X,[],BinLijst).

toBinairLijstAcc(0,Acc,Acc) :- !.
toBinairLijstAcc(Getal,Acc,BinLijst) :-
    X is Getal mod 2,
    Y is Getal // 2,
    toBinairLijstAcc(Y,[X|Acc],BinLijst).

maakBinLijstLengteT(X,L,X) :-
    length(X,LX),
    LX == L,
    !.
maakBinLijstLengteT(Y,L,Res) :-
    maakBinLijstLengteT([0|Y],L,Res).

initTLijst(KleurLijst,Tlijst) :-
    TVolgorde = [(1,1,1),(1,1,0),(1,0,1),(1,0,0),(0,1,1),(0,1,0),(0,0,1),(0,0,0)],
    initTLijst2(KleurLijst,TVolgorde,Tlijst).
initTLijst2([],[],[]).
initTLijst2([Kleur|Rest1],[(X,Y,Z)|Rest2],[t(X,Y,Z,Kleur)|TRest]) :-
    initTLijst2(Rest1,Rest2,TRest).

genereerVolgende(Autom,L,Tlijst,Out) :-
    genereerVolgende2(Autom,L,L,Tlijst,Out).

genereerVolgende2(_,0,_,_,[]).
genereerVolgende2(Autom,Index,L,Tlijst,[VolgKleur|Out]) :-
    getDrieTupleIndex(Autom,Index,L,(X,Y,Z)),
    member(t(X,Y,Z,VolgKleur),Tlijst),
    NewIndex is Index - 1,
    genereerVolgende2(Autom,NewIndex,L,Tlijst,Out).

getDrieTupleIndex(Autom,Index,L,Tuple) :-
    NewIndex is Index - 1,  % Om probleem met index die starten van 1 op te lossen
    Links is (NewIndex - 1) mod L,
    Rechts is (NewIndex + 1) mod L,
    getElem(Autom,Links,LE),
    getElem(Autom,NewIndex,IE),
    getElem(Autom,Rechts,RE),
    vertaalKleurToBin(LE,BinLE),
    vertaalKleurToBin(IE,BinIE),
    vertaalKleurToBin(RE,BinRE),
    Tuple = (BinLE,BinIE,BinRE).

getElem([X|_],0,X).
getElem([_|Rest],Y,El) :-
    NewY is Y - 1,
    getElem(Rest,NewY,El).

vertaalKleurToBin(zwart,0).
vertaalKleurToBin(wit,1).

constructOut(Lijst,Out) :-
    constructOut2(Lijst,[],Out). % Met accumulator werken om lijst (die omgekeerd was) terug in volgorde te zetten

constructOut2([],Acc,Acc).
constructOut2([X|Rest],Acc,Out) :-
    vertaalKleurToBin(Kleur,X),
    constructOut2(Rest,[Kleur|Acc],Out).

%% TEST

test1(Out) :- volgende_generatie([wit,zwart,zwart,wit,zwart,wit],105,Out).


%%%% Vraag 2

eerste_al_gezien(Autom,Getal,Out) :-
    volgende_generatie(Autom,Getal,Gen1),
    Generaties = [Gen1],
    volgendeGeneratiesTotMatch(Generaties,Getal,Out).

volgendeGeneratiesTotMatch([Vorig|Rest],Getal,Match) :-
    volgende_generatie(Vorig,Getal,NextGen),
    (alGezien(NextGen,[Vorig|Rest]) ->
        Match = NextGen
    ;
        volgendeGeneratiesTotMatch([NextGen|[Vorig|Rest]],Getal,Match)
    ).

alGezien(Gen,VorigeGen) :-
    length(Gen,L),
    NewL is L - 1,
    bepaalAlternatieven(NewL,[Gen],Alternatieven),
    match(Alternatieven,VorigeGen).

bepaalAlternatieven(0,Acc,Acc) :- !.
bepaalAlternatieven(L,[Vorig|Rest],Alternatieven) :-
    schuifDoor(Vorig,Alternatief),
    NewL is L - 1,
    bepaalAlternatieven(NewL,[Alternatief|[Vorig|Rest]],Alternatieven).

schuifDoor([X|Rest],Res) :-
    append(Rest,[X],Res).

match([Alternatief|_], VorigeGen) :- member(Alternatief,VorigeGen).
match([_|Rest], VorigeGen) :-
        match(Rest,VorigeGen).

%% TEST

test2(Out) :- eerste_al_gezien([wit,zwart,zwart,wit,zwart,wit],105,Out).
