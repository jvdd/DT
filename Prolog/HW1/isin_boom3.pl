isin_boom(leeg,_,0).
isin_boom(node(leeg,leeg,W),W,1).
isin_boom(node(leeg,leeg,W),V,0) :- dif(W, V).
isin_boom(node(L,R,W),Val,Aantal) :-
	dif(L, leeg),
	dif(R, leeg),
	isin_boom(node(leeg,leeg,W),Val,AantalW),
	isin_boom(L,Val,AantalL),
	isin_boom(R,Val,AantalR),
	Aantal is AantalW + AantalL + AantalR.
	