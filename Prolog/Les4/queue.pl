q_init(X-X).

q_push(X-Y ,A , X-Z) :-
    Y = [A|Z].

q_pop(X-Y, A, Z-Y) :-
    X = [A|Z].
