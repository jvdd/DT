deleteList(X,[X | R],R).
deleteList(X,[Y | R], [Y | S]) :-
    deleteList(X,R,S).
