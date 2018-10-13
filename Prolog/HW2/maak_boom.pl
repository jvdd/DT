maak_boom([],leeg).
maak_boom([A|B],node(L,R,A)) :-
	mid_split(B,LB,RB),
	maak_boom(LB,L),
	maak_boom(RB,R).

mid_split(List,A,B) :-
	mid_split(List,List,A,B), !.
	mid_split(B,[],[],B).
mid_split(W,[_],[],W).
mid_split([A|B],[_,_|Rest],[A|Ra],R) :-
	mid_split(B,Rest,Ra,R).
/*
mid_split([H|T],[_,_|T2],[H|A],B) :-
	mid_split(T,T2,A,B).
*/

/*
maak_boom([],leeg).
maak_boom([A|B],node(L,R,A)) :-
	length(B,Length)
	Mid is Length // 2
	maak_boom(Mid,B,L,R).

maak_boom(Mid,[A|B],L,R) :-
	(Mid = 0 ->
		maak_boom(Mid,[A|B],R)
	;
	 maak_boom()

	).
*/

/*
maak_boom([],leeg).
maak_boom([A|B],node(L,R,W)) :-
	(
	 L = leeg ->
		maak_boom(B,node(node(leeg,leeg,A),leeg,W))
	;
	 R = leeg ->
		 maak_boom(B,L,(leeg,node(leeg,leeg,A),W))
	;
	 var(W) ->
		 L = leeg, R = leeg, W is A,
		 maak_boom(B,node(L,R,W))
	).
*/
