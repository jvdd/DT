
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% HW 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% GRAAF
knoop(a).
knoop(b).
knoop(c).

boog(a,b,3).
boog(b,c,2).
boog(a,c,1).

%% Vraag 1
% EXTRA INFOR OVER KRUSKAL
/*
Gegeven een samenhangende gewogen graaf G(V,E) met een verzameling knopen
V = fv1; v2; : : : ; vng. De volgende procedure is een algoritme dat een
minimale opspannende boom T construeert.

1. Initialisatie: T := ;
2. Stop?: Indien T (n 􀀀 1) bogen heeft, stop.
3. Voeg boog toe: Voeg aan T toe een boog b met minimaal gewicht en
die bovendien geen kring veroorzaakt indien toegevoegd aan T. Ga naar
Stop?.
*/

kruskal(Mob) :-
    Mob = T,
    findall(X,knoop(X),Knopen),
    length(Knopen,Len),
    vindAlleBogen(Bogen),
    berekenMob(Len,Bogen,[],T).

vindAlleBogen(Bogen) :-
    findall(b(Z,X,Y),boog(X,Y,Z),USBogen),
    sort(USBogen,Bogen).

berekenMob(1,_,Acc,Acc).
berekenMob(Len,Bogen,Acc,Mob) :-
    volgendeTak(Bogen,Acc,Tak),
    NewLen is Len - 1,
    berekenMob(NewLen,Bogen,[Tak|Acc],Mob).

volgendeTak([b(Z,X,Y)|Rest],Mob,Tak) :-
        (geenLus(X,Y,Mob) ->
            Tak = boog(X,Y,Z)
        ;
            volgendeTak(Rest,Mob,Tak)
        ).

geenLus(X,Y,Mob) :-
    \+ (
          (member(boog(X,_,_),Mob) ; member(boog(_,X,_),Mob))
         , % &&
          (member(boog(Y,_,_),Mob) ; member(boog(_,Y,_),Mob))
       ).

test1(Mob) :- kruskal(Mob).


%% Vraag 2
generateAndTest(Mob) :-
    findall(X,knoop(X),Knopen),
    length(Knopen,Len),
    generate(Len,OBs),
    test(OBs,Mob).

generate(Len,OBs) :-
    vindAlleBogen(Bogen),
    findall(OB,vindOB(Len,Bogen,OB),OBs).

vindOB(Len,Bogen,OB) :-
    vindOB(Len,Bogen,[],OB).

vindOB(1,_,Acc,Acc).
vindOB(Len,Bogen,Acc,OB) :-
    vindLegitBoog(Bogen,Acc,Boog),
    NewLen is Len - 1,
    vindOB(NewLen,Bogen,[Boog|Acc],OB).

vindLegitBoog([b(Z,X,Y)|_],OB,boog(X,Y,Z)) :- geenLus(X,Y,OB).
vindLegitBoog([_|Rest],OB,Boog) :- vindLegitBoog(Rest,OB,Boog).

test([OB|Rest],Mob) :-
    totCost(OB,Cost),
    test(Rest,Cost,OB,Mob).

test([],_,Acc,Acc).
test([OB|Rest],MinCost,Acc,Mob) :-
    totCost(OB,Cost),
    (Cost < MinCost ->
        test(Rest,Cost,OB,Mob)
    ;
        test(Rest,MinCost,Acc,Mob)
    ).

totCost([],0).
totCost([boog(_,_,X)|Rest],Cost) :-
    totCost(Rest,RCost),
    Cost is X + RCost.

test2(Mob) :- generateAndTest(Mob).
