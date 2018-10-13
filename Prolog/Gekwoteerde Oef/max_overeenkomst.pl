% OPDRACHT 1: max_overeenkomst/4


max_overeenkomst(StringLijst1, StringLijst2, Match, Len) :-
    vindMatch(StringLijst1, StringLijst2, StringMatches),
    sort(StringMatches, SortedStringMatches),
    last(SortedStringMatches, (Len, UnRevMatch)),
    reverse(UnRevMatch, Match).

vindMatch(StringLijst1, StringLijst2, StringMatches) :-
    vindMatch(StringLijst1, StringLijst2, StringLijst2, [], StringMatches).

vindMatch([], _, _, StringMatches, StringMatches) :- !.
vindMatch([X|Rest], StringLijst2, OrigStringLijst2, Acc, StringMatches) :-
    (
    member(X, StringLijst2) ->
        vindRestLijst2(X, StringLijst2, RestLijst2),
        vindRestStringMatch([X|Rest], [X|RestLijst2], String),
        length(String, Len),
        vindMatch([X|Rest], RestLijst2, OrigStringLijst2, [(Len, String)|Acc], StringMatches)
    ;
        vindMatch(Rest, OrigStringLijst2, OrigStringLijst2, Acc, StringMatches)
    ).

vindRestLijst2(X, [X|Rest], Rest) :- !.
vindRestLijst2(X, [_|Rest], RestLijst2) :-
    vindRestLijst2(X, Rest, RestLijst2).

vindRestStringMatch([X|Rest1], [X|Rest2], String) :-
    vindRestStringMatch(Rest1, Rest2, [X], String).

vindRestStringMatch([W1|_], [W2|_], String, String) :-
    W1 \= W2.
vindRestStringMatch([W|Rest1], [W|Rest2], Acc, String) :-
    vindRestStringMatch(Rest1, Rest2, [W|Acc], String).
