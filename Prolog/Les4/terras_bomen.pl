terras_tot_boom(b1,4).
terras_tot_boom(b2,4).

boom_tot_boom(b1,b2,4).



paden(PS) :-
	bomen(Bomen),
	findall(L-P, (pad(Bomen,[t],P), lengte(P,0,L)), PS).

padensorted(PSS) :-
	paden(PS),
	sort(PS,PSS).

bomen(L) :-
    findall(B, terras_tot_boom(B, _), L).

pad([], Acc, [t|Acc]) :-!.
pad(Bomen, Acc, R) :-
	select(B, Bomen, NBomen),
	(pad(NBomen, [B|Acc], R)
	;
	 pad(NBomen, [B,t|Acc], R)
	).

lengte([_X], L, L) :- !.
lengte([t,B|Rest], L1, L) :-
	terras_tot_boom(B, LT),
	L2 is L1 + LT,
	lengte([B|Rest],L2, L).
lengte([B1,B2|Rest],L1,L) :-
	(boom_tot_boom(B1,B2,LB); boom_tot_boom(B2,B1,LB))
	L2 is L1 + LB,
	lengte([B2|Rest],L2,L).
lengte([B,t|Rest],L1,L) :-
	terras_tot_boom(B,LT),
	L2 is L1 + LT,
	lengte([t|Rest],L2,L).
