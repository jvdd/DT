apend([],L,L).
apend([X | Rest],T,[X | ARest]) :-
	apend(Rest,T,ARest).