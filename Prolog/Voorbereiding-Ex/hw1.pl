
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% HW 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Vraag 1
isin_boom(node(_,_,W),W).
isin_boom(node(L,R,_),W) :-
    isin_boom(L,W);
    isin_boom(R,W).

test11 :- isin_boom(node(node(leeg,leeg,7),node(leeg,leeg,8),7),12).
test12 :- isin_boom(node(node(leeg,leeg,7),node(leeg,leeg,8),7),7).
test13(X) :- isin_boom(node(node(leeg,leeg,7),node(leeg,leeg,8),7),X).


%% Vraag 2
% SLECHTE IMPLEMENTATIE
/*
isin_boom(Boom,X,Aantal) :-
    (\+ isin_boom(Boom,X) ->
        Aantal = 0
    ;
        findall(X,isin_boom(Boom,X),Lijst),
        length(Lijst,Aantal)
    ).
*/

% ANDERE IMPLEMENTATIE
isin_boom(leeg,_,0).
isin_boom(node(L,R,W),X,Aant) :-
    isin_boom(L,X,A1),
    isin_boom(R,X,A2),
    (W = X ->
        Aant is A1 + A2 + 1
    ;
        Aant is A1 + A2
    ).

test21(Aantal) :- isin_boom(node(node(leeg,leeg,7),node(leeg,leeg,8),7),7,Aantal).
test22(Aantal) :- isin_boom(node(node(leeg,leeg,7),node(leeg,leeg,8),7),8,Aantal).
test23(Aantal) :- isin_boom(node(node(leeg,leeg,7),node(leeg,leeg,8),7),12,Aantal).
test24(X,Aantal) :- isin_boom(node(node(leeg,leeg,7),node(leeg,leeg,8),7),X,Aantal).
test25(X) :- isin_boom(node(node(leeg,leeg,7),node(leeg,leeg,8),7),X,1).
% LAATSTE 2 TESTS KLOPPEN NOG STEEDS NIET VOLLEDIG
% Nochtans zelfde code als prof...


%% Vraag 3
verwijder_node(leeg,_,leeg).
verwijder_node(node(L,R,W),W,Boom):- !,
    ((L = leeg, R = leeg) ->
        Boom = leeg
    ;
        (L \= leeg ->
            vindBlad(L,node(leeg,leeg,Bval)),
            verwijderBlad(L,NewL),
            verwijder_node(NewL,W,BoomL),
            verwijder_node(R,W,BoomR),
            Boom = node(BoomL,BoomR,Bval)
        ;
            vindBlad(R,node(leeg,leeg,Bval)),
            verwijderBlad(R,NewR),
            verwijder_node(L,W,BoomL),
            verwijder_node(NewR,W,BoomR),
            Boom = node(BoomL,BoomR,Bval)
        )
    ).
verwijder_node(node(L,R,V),W,node(BoomL,BoomR,V)) :-
        verwijder_node(L,W,BoomL),
        verwijder_node(R,W,BoomR).

vindBlad(node(leeg,leeg,W), node(leeg,leeg,W)) :- !.
vindBlad(node(L,_,_),Blad) :- vindBlad(L,Blad).
vindBlad(node(leeg,R,_),Blad) :- vindBlad(R,Blad).

verwijderBlad(node(leeg,leeg,_),leeg) :- !.
verwijderBlad(node(leeg,R,V),node(leeg,NewR,V)) :- !,
    verwijderBlad(R,NewR).
verwijderBlad(node(L,R,V),node(newL,R,V)) :-
    verwijderBlad(L,newL).

test31(Boom) :- verwijder_node(node(node(leeg,leeg,7),node(leeg,leeg,8),7), 7, Boom).
test32(Boom) :- verwijder_node(node(node(leeg,leeg,7),node(leeg,leeg,8),7), 8, Boom).
% VOLDOET NIET AAN DE EISEN VAN DE prof


%% Vraag 4
% BASIS VERSIE
/*
gen_boom(1,node(leeg,leeg,1)) :- !.
gen_boom(N,node(leeg,Rboom,N)) :-
    X is N - 1,
    gen_boom(X,Rboom).
*/

% GEBALANCEERDE VERSIE
gen_boom(N,node(L,R,Halfplus1)) :-
    Half is N // 2,
    Halfplus1 is Half + 1,
    Halfplus2 is Half + 2,
    gen_bal_boom(1,Half,L),
    gen_bal_boom(Halfplus2,N,R).

gen_bal_boom(X,X,node(leeg,leeg,X)) :- !.
gen_bal_boom(X,Y,node(node(leeg,leeg,X),leeg,Y)) :-
    Y - X =:= 1 ,!.
gen_bal_boom(X,Y,node(L,R,Half)) :-
    Half is (X + Y) // 2,
    Halfmin1 is Half - 1,
    Halfplus1 is Half + 1,
    gen_bal_boom(X,Halfmin1,L),
    gen_bal_boom(Halfplus1,Y,R).

test41(Boom) :- gen_boom(3,Boom).
test42(Boom) :- gen_boom(6,Boom).
test43(Boom) :- gen_boom(7,Boom).
% MODELOPLOSSING WEL WAT MOOIER
