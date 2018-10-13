/*
S,M tussen 1 en 9,  rest tussen 0 en 9, allemaal verschillende getallen
D + E = Y + Overdracht1Overdracht1 + N + R = E + O2  …

Prolog programma
- Generate and test
- Generate: member/delete        Test: sum(C0,A,B,S,C1).
- Test zo vlug mogelijk
- Gebruik freeze
*/

sendMoreMoney(S,E,N,D,M,O,R,Y) :- % D,E,Y,N,R,0,S,M
    %[S,E,N,D],
    %[M,O,R,E],
    %[M,O,N,E,Y],
    Vars = [],
    initVar(D,Vars,Vars1),
    initVar(E,Vars1,Vars2),
    initNewVar(D,E,0,Y,O1),
    \+ member(Y,Vars2),
    Vars3 = [Y|Vars2],
    initVar(N,Vars3,Vars4),
    initVar(R,Vars4,Vars5),
    initNewVar(N,R,O1,E,O2),
    initVar(O,Vars5,Vars6),
    initNewVar(E,O,O2,N,O3),
    initVar(S,Vars6,Vars7), S \= 0,
    initVar(M,Vars7,_), M \= 0,
    initNewVar(S,M,O3,O,O4),
    M = O4.

initVar(X,Vars,NewVars) :-
    member(X,[0,1,2,3,4,5,6,7,8,9]),
    \+ member(X,Vars),
    NewVars = [X|Vars].

initNewVar(X,Y,O,Var,NO) :-
    S is X + Y + O,
    (S >= 10 ->
        NO = 1,
        Val is S - 10,
        Var = Val
    ;
        NO = 0,
        Var = S
    ).
