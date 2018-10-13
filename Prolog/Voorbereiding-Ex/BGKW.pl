/*
Als test: zoekprobleem oplossen zoalsboer staat met wolf – geit – kool
op de linkeroever en moet met een boot naar de overkant.
Hij kan hoogstens 1 meenemen in de boot. Maar, hij kan de wolf niet
alleen bij de geit laten en de geit niet alleen bij de kool….
*/

boerGeitKoolWolf(Acties) :-
    Start = (['B','G','K','W'],[]),
    vindPad([Start],Acties).

vindPad([Vorig|Rest],Acties) :-
    succes(Vorig), !,
    Acties = [Vorig|Rest].
vindPad([Vorig|Rest],Acties) :-
    volgendeStap(Vorig,Volgend),
    geldigeStap(Volgend),
    geenLus(Volgend,Rest),
    vindPad([Volgend|[Vorig|Rest]],Acties).

succes(([],_)).

volgendeStap((L,R),Volgend) :-
    (member('B',L) ->    % Boer staat aan linkeroever
        delete(L,'B',NewL),
        NewR = ['B'|R],
        (
            Volgend = (NewL,NewR)
            ; % BACKTRACK MOGELIJKHEDEN
            (
                member(X,NewL),
                delete(NewL,X,NewL2),
                Volgend = (NewL2,[X|NewR])
            )
        )
    ;                    % Boer staat aan rechteroever
        delete(R,'B',NewR),
        NewL = ['B'|L],
        (
            Volgend = (NewL,NewR)
            ; % BACKTRACK MOGELIJKHEDEN
            (
            member(X,NewR),
            delete(NewR,X,NewR2),
            Volgend = ([X|NewL],NewR2)
            )
        )
    ).

geldigeStap((L,R)) :-
    (member('B',L) ->    % Boer staat aan linkeroever
        geldigeOever(R)
    ;                    % Boer staat aan rechteroever
        geldigeOever(L)
    ).

geldigeOever(X) :-
    \+ (member('G',X),(member('W',X);member('K',X))).

geenLus(_,[]) :- !.
geenLus((L1,R1),[(L2,_)|Rest]) :-
    \+ gelijkeElementen(L1,L2),
    geenLus((L1,R1),Rest).

gelijkeElementen([],[]) :- !.
gelijkeElementen([X|Rest1],Lijst) :-
    member(X,Lijst),
    delete(Lijst,X,NewLijst),
    gelijkeElementen(Rest1,NewLijst).
