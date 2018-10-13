
maal(nul,_,nul).
maal(s(nul), X, X).
maal(s(A), B, X):-
	maal(A, B, Y),
	plus_dt(Y, B, X).