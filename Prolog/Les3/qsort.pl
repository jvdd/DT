qsort(Lijst,Sorted) :- !, qsort(Lijst,[],Sorted).
qsort([],L,L).
qsort([Spil|R], Acc, Sorted):-
		split(Spil, R, Kleiner, Groter),
		qsort(Groter, Acc, NewAcc),
		qsort(Kleiner, [Spil|NewAcc], Sorted).

split(_,[],[],[]).
split(Spil,[X|R],Kleiner,Groter) :-
		Spil > X, Kleiner = [X|RestK],
		split(Spil,R,RestK,Groter).
split(Spil,[X|R],Kleiner,Groter) :-
		Spil =< X, Groter = [X|RestG],
		split(Spil,R,Kleiner,RestG).
