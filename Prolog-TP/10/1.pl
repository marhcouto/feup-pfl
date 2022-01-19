:- use_module(library(lists)).

% C

separate(L,P,L1):-
    separate_aux(L,P,Ys,Ns),
    append(Ys,Ns,L1).

separate_aux([],_,[],[]).
separate_aux([H|T],P,[H|Ys],Ns):-
    Goal =.. [P,H],
    call(Goal),
    !,
    separate_aux([H|T],P,Ys,Ns).
separate_aux([H|T],P,Ys,[H|Ns]):-
    separate_aux(T,P,Ys,Ns).

even(X):- o =:= X mod 2.

separate2(L,P,L1):-
    separate2_aux(L,P,L1\Ns,Ns\[]).

separate2_aux([],_,TYs\TYs,TNs\TNs).
separate2_aux([H|T],P,[H|Ys]\TYs,Ns):-
    Goal = .. [P,H],
    call(Goal),!,
    separate2_aux(T,P,Ys\TYs,Ns).
separate2_aux([H|T],P,Ys,Ns\TNs):-
    separate2_aux(T,P,Ys,Ns).