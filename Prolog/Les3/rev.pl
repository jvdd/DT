% NAIEVE VERSIE
nrev([],[]).
nrev([X|R],Result) :-
    nrev(R,OmgekR),
    append(OmgekR,[X],Result).

% SLIMMERE VERSIE
srev(In,Out) :- srev(In,[],Out).

srev([],L,L).
srev([X|R],Acc,Out) :- srev(R,[X|Acc],Out).
