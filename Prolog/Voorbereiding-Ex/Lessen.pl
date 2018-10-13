plus_dt(s(R1), Acc, Result) :- !,
    plus_dt(R1, s(Acc), Result).
plus_dt(_, Acc, Acc).


maal(s(R1), Get2, Result) :- maal(R1, Get2, Get2, Result).

maal(s(R1), Get2, Acc, Result) :- !,
    plus_dt(Get2, Acc, Res),
    maal(R1, Get2, Res, Result).
maal(_, _, Acc, Acc).


% TODO: slide 67 en 68 ppt1
