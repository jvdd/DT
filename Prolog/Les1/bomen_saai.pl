saai(Boom) :- saai(Boom,W).
saai(leeg,_W).
saai(node(L,R,W),W) :-
	saai(L,W),
	saai(R,W).