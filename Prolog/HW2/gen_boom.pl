gen_boom(N,Boom) :- gen_boom(1,N,Boom).

gen_boom(A,B,Boom) :-
	(A > B ->
	    Boom = leeg
	;
	    Mid is (A+B)//2,
	    MidMin is Mid - 1,
	    MidPlus is Mid + 1,
	    Boom = node(Links,Rechts,Mid),
	    gen_boom(A,MidMin,Links),
	    gen_boom(MidPlus,B,Rechts)
	).
