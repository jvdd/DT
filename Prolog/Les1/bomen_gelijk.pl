gelijk(leeg,leeg).
gelijk(node(L1,R1,W1),node(L2,R2,W2)) :- 
	W1 = W2, 
	gelijk(L1,L2), 
	gelijk(R1,R2).