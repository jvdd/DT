vader(paul,koen).
vader(paul,els).
vader(koen,eefje).
vader(koen,marten).
moeder(denise,koen).
moeder(els,vincent).
moeder(els,edith).
moeder(els,pieter).

ouder(P,L) :-
    findall(X,vader(P,X),LL),
    findall(Y,moeder(P,Y),RL),
    append(LL,RL,L).
    %findall(P,(vader(P,K);moeder(P,K)),L).


sibling(L) :-
    findall(s(X,R),((vader(O,R),vader(O,X) ; moeder(O,R),moeder(O,X)), (X@<R)),L).
    % L hierboven als L1 schrijven
    % Dan sort(L1,L) en zo dubbele waarden verwijderen
