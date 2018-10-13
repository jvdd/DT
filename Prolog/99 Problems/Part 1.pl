% http://www.ic.unicamp.br/~meidanis/courses/mc336/2009s2/prolog/problemas/

%% P01
% Find the last element of a list.

my_last([X|[]], X) :- !.    % of my_last([X], X) :- !.
my_last([_|Rest], Last) :-
    my_last(Rest, Last).



%% P02
% Find the last but one element of a list.

my_lastButOne([X|[_|[]]], X) :- !.          % of my_lastButOne([X,_], X) :- !.
my_lastButOne([_|[Y|Rest]], LastButOne) :-  % of my_lastButOne([_,Y|Rest], LastButOne)
    my_lastButOne([Y|Rest], LastButOne).



%% P03
% Find the K'th element of a list.
%   The first element in the list is number 1

element_at(1, [X|_], X) :- !.
element_at(Index, [_|Rest], Element) :-
    NewIndex is Index - 1,  % misschien hier check voor : Index > 1
    element_at(NewIndex, Rest, Element).



%% P04
% Find the number of elements of a list.

size([], 0).
size([_|Rest], Len) :-
    size(Rest, RLen),
    Len is RLen + 1.

/*  Versie met accumulator (efficienter)
size_metAcc(Lijst, Len) :-
    size_metAcc(Lijst, 0, Len).

size_metAcc([], Len, Len).
size_metAcc([_|Rest], Acc, Len) :-
    NewAcc is Acc + 1,
    size_metAcc(Rest, NewAcc, Len).
*/



%% P05
% Reverse a list.

rev(Lijst, Result) :-
    srev(Lijst, Result, []).

srev([], Acc, Acc).
srev([X|Rest], Result, Acc) :-
    srev(Rest, Result, [X|Acc]).



%% P06
% Find out whether a list is a palindrome.
%   A palindrome can be read forward or backward; e.g. [x,a,m,a,x].

palindrome(Lijst, Result) :- palindrome(Lijst, [], Result).

palindrome([X|Rest], Acc, Result) :-
    length(Rest, Len1),
    length(Acc, Len2),
    ( Len1 == Len2 ->
        sameList(Rest, Acc, Result)
    ;
      Len3 is Len2 + 1,
      ( Len1 == Len3 ->
          sameList(Rest, [X|Acc], Result)
      ;
        palindrome(Rest, [X|Acc], Result)
      )
    ).

sameList([], [], true).
sameList([X|Rest1], [Y|Rest2], Result) :-
    (X == Y ->
        sameList(Rest1, Rest2, Result)
    ;
        Result = false
    ).



%% P07
% Flatten a nested list structure.
%   Transform a list, possibly holding lists as elements into a `flat' list
%   by replacing each list with its elements (recursively).

my_flatten([], []).
my_flatten([X|Rest], Result) :-
    (is_list(X) ->
        my_flatten(X, Res1),
        my_flatten(Rest, Res2),
        append(Res1, Res2, Result)
    ;
        my_flatten(Rest, Res2),
        Result = [X|Res2]
    ).



%% P08
% Eliminate consecutive duplicates of list elements.
%   If a list contains repeated elements they should be replaced with a single
%   copy of the element. The order of the elements should not be changed.

compress([], []) :- !.
compress([X], [X]) :- !.
compress([X,Y|Rest], [X|Result]) :-
    (X == Y ->
        rmBegin(X, Rest, Res),
        compress(Res, Result)
    ;
        compress([Y|Rest], Result)
    ).

rmBegin(_, [], []) :- !.
rmBegin(X, [X|Rest], Res) :- !,
    rmBegin(X, Rest, Res).
rmBegin(_, Lijst, Lijst).

% Mooier en efficienter alternatief
/*
compress([],[]).
compress([X],[X]).
compress([X,X|Xs],Zs) :- compress([X|Xs],Zs).
compress([X,Y|Ys],[X|Zs]) :- X \= Y, compress([Y|Ys],Zs).
*/



%% P09
% Pack consecutive duplicates of list elements into sublists.
%   If a list contains repeated elements they should be placed in separate sublists.

pack([], []).
pack([X], [X]).
pack([X,X|Xs], [SL|Res]) :-
    findSL(X, [X,X|Xs], SL),
    rmBegin(X, Xs, RmX),
    pack(RmX,Res).
pack([X,Y|Ys], [[X]|Res]) :-
    X \= Y,
    pack([Y|Ys], Res).

findSL(_, [], []).
findSL(X, [X|Xs], [X|Zs]) :- findSL(X, Xs, Zs).
findSL(X, [Y|_], []) :- X \= Y.


%% P10
% Run-length encoding of a list.
%   Use the result of problem P09 to implement the so-called run-length encoding
%   data compression method. Consecutive duplicates of elements are encoded as
%   terms [N,E] where N is the number of duplicates of the element E.

encode(Lijst, Result) :-
    pack(Lijst, NotEncRes), !,
    encodeRes(NotEncRes, Result).

encodeRes([], []).
encodeRes([[X|Xs]|Rest], [[Len, X]|Result]) :-
    length([X|Xs], Len),
    encodeRes(Rest, Result).
