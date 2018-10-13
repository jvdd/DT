edge(1,a,b).
edge(1,b,c).
edge(1,c,d).
edge(1,d,e).
edge(1,e,a).
edge(2,a,f).
edge(2,b,h).
edge(2,c,j).
edge(2,d,l).
edge(2,e,n).
edge(3,f,g).
edge(3,g,h).
edge(3,h,i).
edge(3,i,j).
edge(3,j,k).
edge(3,k,l).
edge(3,l,m).
edge(3,m,n).
edge(3,n,o).
edge(3,o,f).
edge(4,g,p).
edge(4,i,q).
edge(4,k,r).
edge(4,m,s).
edge(4,o,t).
edge(5,p,q).
edge(5,q,r).
edge(5,r,s).
edge(5,s,t).
edge(5,t,p).

node(X):-
   edge(_, X, _);
   edge(_, _, X).
