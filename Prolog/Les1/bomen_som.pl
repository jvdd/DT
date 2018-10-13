som(leeg,0).
som(node(L,R,W), Totaal) :-
	som(L,TotaalL),
	som(R,TotaalR),
	Totaal is TotaalL + TotaalR + W.
