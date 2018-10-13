send([S,E,N,D] + [M,O,R,E] = [M,O,N,E,Y]) :-
    initValEnRest(D,[0,1,2,3,4,5,6,7,8,9],RestD),
    initValEnRest(E,RestD,RestE),
    somGetallen(0,D,E,Y,Overdracht1),
    initValEnRest(Y,RestE,RestY),
    initValEnRest(N,RestY,RestN),
    initValEnRest(R,RestN,RestR),
    somGetallen(Overdracht1,N,R,E,Overdracht2),
    initValEnRest(O,RestR,RestO),
    somGetallen(Overdracht2,E,O,N,Overdracht3),
    initValEnRest(S,RestO,RestS), S =\= 0,
    initValEnRest(M,RestS,_), M =\= 0,
    somGetallen(Overdracht3,S,M,O,M).

somGetallen(OudOverdracht,A,B,S,NieuwOverdracht) :-
    X is OudOverdracht + A + B,
    (X < 10 ->
        S = X,
        NieuwOverdracht = 0
    ;
        S is X - 10,
        NieuwOverdracht = 1
    ).

initValEnRest(Val,Lijst,Rest) :-
    delete(Val,Lijst,Rest).

delete(X, [X|R] ,R).
delete(X, [Y|R], [Y|S]) :-
    delete(X,R,S).



/*
p([S,E,N,D],[M,O,R,E],[M,O,N,E,Y]) :-
    testSom([S,E,N,D],[M,O,R,E],[M,O,N,E,Y]),
    member(S,[1,2,3,4,5,6,7,8,9]),
    member(M,[1,2,3,4,5,6,7,8,9]),
    vindVar(E), vindVar(N), vindVar(D),
    vindVar(O), vindVar(R), vindVar(N),
    vindVar(Y).

vindVar(X) :-
    member(X,[0,1,2,3,4,5,6,7,8,9]).

testSom([],[],0).
testSom([A|RestL1],[B|RestL2],TotSom) :-
    totSom(Som,TotSom),
    freeze(A,NewSom1 is Som - A),
    freeze(B,NewSom2 is NewSom1 - B),
    testSom(RestL1,RestL2,NewSom2).

totSom(X,Lijst) :-
    totSom(0,X,Lijst).

totSom(X,X,[]).
totSom(X,B,[A|Rest]) :-
    freeze(A, NewX is X + A),
    totSom(NewX,B,Rest).
*/
