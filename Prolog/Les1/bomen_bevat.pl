bevat(node(_,_,W),W).
bevat(node(L,_,_),W) :- bevat(L,W).
bevat(node(_,R,_),W) :- bevat(R,W).