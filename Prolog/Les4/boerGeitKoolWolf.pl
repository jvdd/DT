% Lstap is de lijst van stappen die uitgevoerd moeten worden om vanuit de huidige
% Toestand een beoogde eindtoestand te bereiken en waarbij
% Hist de toestanden bevat waarin we al geweest zijn.
solve_dfs(T, _, []) :- einde(T),!.
solve_dfs(T1, Hist, [Stap|Lstap]) :-
	overgang(T1, Stap, T2),
	geldig(T2),
    \+ member(T2, Hist),
	solve_dfs(T2, [T2|Hist], Lstap).

test(Lstap) :- begin(T), solve_dfs(T, [T], Lstap).

begin(wgk(links,[g,k,w],[])).
einde(wgk(rechts,[],[g,k,w])).

overgang(wgk(links,L1,R1),lr(Kand),wgk(rechts,L2,R2)):-
	delete(Kand,L1,L2),
	insert(Kand,R1,R2).
overgang(wgk(rechts,L1,R1),rl(Kand),wgk(links,L2,R2)):-
	delete(Kand,R1,R2),
	insert(Kand,L1,L2).
overgang(wgk(B1,L,R),alleen,wgk(B2,L,R)):-
    andere(B1,B2).

andere(links,rechts).
andere(rechts,links).

geldig(wgk(links,L,R)):- \+ gevaar(R ).
geldig(wgk(rechts,L,R)) :- \+ gevaar(L).

gevaar(L) :- member(wolf,L), member(geit,L).
gevaar(L):- member(geit,L), member(kool,L).

insert( Kand,L,Sorted):- sort([Kand|L], Sorted).
