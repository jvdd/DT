sl1(L1,L2)  :-
	append(A,_,L2),
	append(_,L1,A).               


sl2(L1, L2) :-
	append(_,L1,A),
	append(A,_,L2).