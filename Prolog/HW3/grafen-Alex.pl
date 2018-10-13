
% OPGAVE 1:
kruskal(Bogen, Gewicht):-
   kruskal(false, Bogen, Gewicht).

kruskal(Meerdere, Bogen, Gewicht):-
   alle_bogen(AlleBogen),
   alle_knopen(AlleKnopen),
   kruskal(AlleBogen, AlleKnopen, Meerdere, Bogen, Gewicht).

kruskal(AlleBogen, AlleKnopen, Meerdere, BogenZonderGewicht, Gewicht):-
   zip_all(AlleBogen, Zip),
   sort(Zip, Unzip),
   zip_all(JuisteBogen, Unzip),
   sort(AlleKnopen, JuisteKnopen),
   kruskal(JuisteBogen, JuisteKnopen, Meerdere, [], Bogen, Gewicht),
   verwijder_gewicht(Bogen, BogenZonderGewicht).

kruskal([], [], _, [], [], 0).
kruskal(_, [Knoop], _, Accumulator, [], 0):-
   !, bevat(Accumulator, Knoop).
kruskal([], [Knoop | Knopen], true, Accumulator, Boom, Gewicht):-
   bevat(Accumulator, Knoop),
   kruskal([], Knopen, true, Accumulator, Boom, Gewicht).
kruskal(Bogen, Teller, Meerdere, Accumulator, Boom, Gewicht):-
   kies_minimaal(Bogen, boog(A, B, _), Rest),
   verbonden(A, B, Accumulator), !,
   kruskal(Rest, Teller, Meerdere, Accumulator, Boom, Gewicht).
kruskal(Bogen, [_ | Teller], Meerdere, Accumulator, [boog(A, B, G) | NieuweBoom], Gewicht):-
   kies_minimaal(Bogen, boog(A, B, G), Rest),
   test_volgorde(Accumulator, boog(A, B, G)),
   kruskal(Rest, Teller, Meerdere, [boog(A, B, G) | Accumulator], NieuweBoom, NieuwGewicht),
   Gewicht is NieuwGewicht + G.

zip(boog(A, B, G), (G, boog(A,B,G))).

zip_all([], []).
zip_all([O | Oud], [N | Nieuw]):-
   zip(O, N),
   zip_all(Oud, Nieuw).

test_volgorde([], _).
test_volgorde([Kop | _], Boog):-
   zip(Kop, K),
   zip(Boog, B),
   K @< B.

kies_minimaal([boog(A, B, G) | Bogen], Keuze, Rest):-
   kies_minimaal(G, [boog(A, B, G) | Bogen], Keuze, Rest).

kies_minimaal(G, [boog(A, B, G) | Bogen], boog(A, B, G), Bogen).
kies_minimaal(G, [boog(A, B, G) | Bogen], Keuze, [boog(A, B, G) | Rest]):-
   kies_minimaal(G, Bogen, Keuze, Rest).


% OPGAVE 2:
naief(Bogen, Gewicht):-
   alle_bogen(AlleBogen),
   alle_knopen(AlleKnopen),
   naief(AlleBogen, AlleKnopen, Bogen, Gewicht).

naief(AlleBogen, AlleKnopen, BogenZonderGewicht, Gewicht):-
   sort(AlleBogen, JuisteBogen),
   sort(AlleKnopen, JuisteKnopen),
   findall((G, Boom), (
      alle_bomen(JuisteBogen, JuisteKnopen, Boom, G),
      sort(Boom, Boom),
      test_boom(JuisteKnopen, Boom)
   ),
   AlleBomen),
   sort(AlleBomen, JuisteBomen),
   JuisteBomen = [(Gewicht, _) | _],
   member((Gewicht, Bogen), JuisteBomen),
   verwijder_gewicht(Bogen, BogenZonderGewicht).

alle_bomen(_, [], [], 0).
alle_bomen(_, [_], [], 0):- !.
alle_bomen(Bogen, [_ | Teller], Boom, Gewicht):-
   kies(Bogen, boog(A, B, G), Rest),
   alle_bomen(Rest, Teller, NieuweBoom, NieuwGewicht),
   Boom = [boog(A, B, G) | NieuweBoom],
   Gewicht is NieuwGewicht + G.

kies([Boog | Bogen], Boog, Bogen).
kies([Boog | Bogen], Keuze, [Boog | Rest]):-
   kies(Bogen, Keuze, Rest).

test_boom([], []).
test_boom([A], Boom):-
   bevat(Boom, A).
test_boom([A, B | Knopen], Boom):-
   bevat(Boom, A),
   verbonden(A, B, Boom), !,
   test_boom([B | Knopen], Boom).



alle_knopen(Knopen):-
   findall(Knoop, knoop(Knoop), Knopen).

alle_bogen(Bogen):-
   findall(boog(A, B, G), boog(A, B, G), Bogen).

bevat([boog(X, _, _) | _], X):- !.
bevat([boog(_, X, _) | _], X):- !.
bevat([_ | Xs], X):-
   bevat(Xs, X).

verbonden(A, A, _).
verbonden(A, B, Bogen):-
   verbonden(A, A, B, Bogen, Bogen).

verbonden(Vorige, A, B, [_ | Teller], Bogen):-
   direct_verbonden(A, B, Bogen);
   direct_verbonden(A, C, Bogen),
   C \= Vorige,
   verbonden(A, C, B, Teller, Bogen).

direct_verbonden(A, B, Bogen):-
   member(boog(A, B, _), Bogen);
   member(boog(B, A, _), Bogen).

verwijder_gewicht([], []).
verwijder_gewicht([boog(A,B,_) | Oud], [boog(A,B) | Nieuw]):-
   verwijder_gewicht(Oud, Nieuw).
