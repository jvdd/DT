
/*
plus_dt(nul, A, X):- X = A.

plus_dt(A, nul, X):- X = A.

plus_dt(A, s(B), X):- plus_dt(s(A), B, X).

*/



plus_dt(X,nul,X).

plus_dt(A,s(B),X):- plus_dt(s(A),B,X).