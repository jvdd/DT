verzamel_waarden(leeg, []).
verzamel_waarden(node(L, R, W), T) :-
    verzamel_waarden(L, LT),
    verzamel_waarden(R, RT),
    append(LT, [W|RT], T).
