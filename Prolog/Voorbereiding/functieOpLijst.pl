doorGeef(_, [], []) :- !.
doorGeef(Functie, [X|Rest], [Y|Oplossingen]) :-
    call(Functie, X, Y),
    doorGeef(Functie, Rest, Oplossingen).

% Met Accumulator is de volgorde omgekeerd

kwadraat(X, Y) :- Y is X * X.
