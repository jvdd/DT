merge_sort([],[]).
merge_sort([W],[W]).
merge_sort([A,B|Rest],Sorted) :-
    split([A,B|Rest],L,R),
    merge_sort(L,S1),
    merge_sort(R,S2),
    merge(S1,S2,Sorted).

split([],[],[]).
split([A,B|Rest],[A|RestA],[B|RestB]) :-
    split(Rest,RestA,RestB).
split([W],[W],[]).

merge(W,[],W).
merge([],W,W).
merge([A|RestA],[B|RestB],[X|M]) :-
    (A =< B ->
        merge(RestA,[B|RestB],M),
        X = A
    ;
     A > B ->
        merge([A|RestA],RestB,M),
        X = B
    ).
