maak_boom([W|Rest], Boom) :-
    length(Rest, L),
    Mid is L // 2,
    split(Rest, Mid, LLijst),
    deleteSL(LLijst, Rest, RLijst),
    (LLijst = [] ->
        Links = leeg
    ;
        swapLaatsteMet1e(LLijst, NewLLijst), % Zodat prefix doorlopen wordt
        maak_boom(NewLLijst, Links)
    ),
    (RLijst = [] ->
        Rechts = leeg
    ;
        maak_boom(RLijst, Rechts)
    ),
    Boom = boom(Links, Rechts, W).

split(Lijst, X, Splitted) :-
    split(Lijst, X, [], Splitted).

split(_, 0, Acc, Acc).
split([W|Rest], X, Acc, Splitted) :-
    NewX is X - 1,
    split(Rest, NewX, [W|Acc], Splitted).

deleteSL([], LijstZonderSL, LijstZonderSL).
deleteSL([X|Rest], Lijst, LijstZonderSL) :-
    select(X, Lijst, NewLijst),
    deleteSL(Rest, NewLijst, LijstZonderSL).

swapLaatsteMet1e([Eerste|Rest], SwappedLijst) :-
    last(Rest, Laatste),
    deleteLaatste(Rest, NewRest),
    append([Laatste|NewRest], [Eerste], SwappedLijst).

deleteLaatste([_], []).
deleteLaatste([X|Rest], [X|ZonderLaatste]) :-
    deleteLaatste(Rest, ZonderLaatste).
