% verwijder_node(leeg,_,leeg).
% verwijder_node(Boom,Val,Boom) :- not(isin_boom(Boom,Val)).
% verwijder_node(node(L,R,Val),Val,Boom) :- 
	

% isin_boom(node(_,_,W),W).
% isin_boom(node(L,R,_),W) :-
	% isin_boom(L,W);
	% isin_boom(R,W).
	
	
verwijder_node(leeg,_,leeg).
verwijder_node(node(leeg,leeg,W),W,leeg).
verwijder_node(node(L,R,W),W,Boom):-
	(
	dif(L, leeg);
	dif(R, leeg)
	),
	verwijder_node(R,W,Boom).
verwijder_node(node(L,R,W),Val,Boom) :-
	dif(W,Val),
	verwijder_node(L,Val,X),
	verwijder_node(R,Val,Y),
	Boom = node(X,Y,W).