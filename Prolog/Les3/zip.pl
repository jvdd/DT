zip(Lin,Lout) :-
    zip(Lin,Lout,1).

zip([],[],_).
zip([A|RestIn],[(A,W)|RestOut],W) :-
    NewW is W + 1,
    zip(RestIn,RestOut,NewW).
