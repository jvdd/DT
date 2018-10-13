isin_boom(node(_,_,W),W).
isin_boom(node(L,R,_),W) :-
	isin_boom(L,W);
	isin_boom(R,W).