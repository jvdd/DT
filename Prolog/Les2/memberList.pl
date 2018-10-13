memberList(X,[X | _]).
memberList(X,[_ | R]) :-
    memberList(X,R).
