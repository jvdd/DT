
%%%% String matching
max_overeenkomst(S1,S2,S,Len) :-
    vindMaxOvereenkomst(S1,S2,S2,[],S),
    length(S,Len).

vindMaxOvereenkomst([],_,_,Acc,Acc).
vindMaxOvereenkomst([_|Rest1],[],S2,Acc,S) :-
    vindMaxOvereenkomst(Rest1,S2,S2,Acc,S).
vindMaxOvereenkomst([X|Rest1],[X|Rest2],S2,Acc,S) :-
    !,
    match(Rest1,Rest2,M),
    Match = [X|M],
    length(Match,LM),
    length(Acc,LA),
    (LM > LA ->
        vindMaxOvereenkomst([X|Rest1],Rest2,S2,Match,S)
    ;
        vindMaxOvereenkomst([X|Rest1],Rest2,S2,Acc,S)
    ).
vindMaxOvereenkomst(A,[_|Rest2],S2,Acc,S) :-
    vindMaxOvereenkomst(A,Rest2,S2,Acc,S).

match([],_,[]).
match(_,[],[]).
match([X|Rest1],[X|Rest2],[X|RestMatch]) :- match(Rest1,Rest2,RestMatch).
match(_,_,[]).

test1(S,Len) :- max_overeenkomst([a,b,c,d,e,f,g,h],[x,c,d,e,y,z],S,Len).
test2(S,Len) :- max_overeenkomst([a,b,c,d,e,f,g,h,i],[x,a,b,y,d,e,f,z,e,f,g,h,t],S,Len).
