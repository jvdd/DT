
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% HW 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Vraag 1
maak_boom([],leeg).
maak_boom([X|Rest],node(L,R,X)) :-
    length(Rest,Len),
    Mid is Len // 2,
    split(Mid,Rest,LR,RR),
    maak_boom(LR,L),
    maak_boom(RR,R).

split(0,Rest,[],Rest) :- !.
split(W,[X|Rest],[X|S1],S2) :-
    NewW is W - 1,
    split(NewW,Rest,S1,S2).

test11(Boom) :- maak_boom([1,2,3,4,5],Boom).


%% Vraag 2
% VERKEERDE VERSIE: DOORLOOPT BREEDTE EERST
/*
verzamel_waarden(leeg,[]).
verzamel_waarden(node(L,R,W),Waarden) :-
    Waarden = [W|RestWaarden],
    Queue = [L,R],
    verzamel_waardenQ(Queue,RestWaarden).

verzamel_waardenQ([],[]).
verzamel_waardenQ([leeg|Rest],Waarden) :- verzamel_waardenQ(Rest,Waarden).
verzamel_waardenQ([node(L,R,W)|Rest],[W|RestWaarden]) :-
    append(Rest,[L,R],Queue),
    verzamel_waardenQ(Queue,RestWaarden).
*/

verzamel_waarden(leeg,[]).
verzamel_waarden(node(leeg,leeg,W),[W]) :- !.
verzamel_waarden(node(L,R,W),Waarden) :-
    verzamel_waarden(L,LW),
    verzamel_waarden(R,RW),
    append(LW,[W|RW],Waarden).

test21(Waarden) :- verzamel_waarden(node(node(leeg,node(leeg,leeg,3),2),node(leeg,node(leeg,leeg,5),4),1),Waarden).


%% Vraag 3
merge_sort([],[]) :- !.
merge_sort([X],[X]) :- !.
merge_sort(Lijst,Sorted) :-
    length(Lijst,Len),
    Mid is Len // 2,
    split(Mid,Lijst,L1,L2),
    merge_sort(L1,S1),
    merge_sort(L2,S2),
    merge(S1,S2,Sorted).

merge(X,[],X) :- !.
merge([],X,X).
merge([X|R1],[Y|R2],Sorted) :-
    (X < Y ->
        Sorted = [X|RS],
        merge(R1,[Y|R2],RS)
    ;
        Sorted = [Y|RS],
        merge([X|R1],R2,RS)
    ).

test31(Sorted) :- merge_sort([2,1,34,4,3,6],Sorted).
