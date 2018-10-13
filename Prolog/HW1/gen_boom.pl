gen_boom(0,_).
gen_boom(X,Boom) :-
	NewX is X -1,
	recursgen_boom(NewX,node(leeg,leeg,X),Boom).

recursgen_boom(0,RecursBoom, RecursBoom).	
recursgen_boom(X,RecursBoom,Boom) :-
	NewX is X -1,
	recursgen_boom(NewX,node(leeg,RecursBoom,X), Boom).