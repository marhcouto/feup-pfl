% A
% invert(+List1, ?List2)´
invert([],[]).
invert([H|T],List2):-
    invert(T,List1),
    append(List1,[H],List2).


% B
% del_one(+Elem, +List1, ?List2)
del_one(_,[],[]).
del_one(Elem,[Elem|T1],T1).
del_one(Elem,[H1|T1],[H2|T2]):-
    del_one(Elem,T1,T2),
    H2 is H1.


% C
% del_all(+Elem, +List1, ?List2)
del_all(_,[],[]).
del_all(Elem,[Elem|T1],List2):- del_all(Elem,T1,List2).
del_all(Elem,[H1|T1],[H2|T2]):-
    del_all(Elem,T1,T2),
    H2 is H1.


% D
% del_all_list(+ListElems,+List1,?List2)
del_all_list(_,[],[]).
del_all_list([],List1,List1).
del_all_list([H|T],List1,List2):-
    del_all(H,List1,List3),
    del_all_list(T,List3,List2).


% E
% del_dups(+List1,+List2)
del_dups([],[]).
del_dups([H|T],List2):-
    member(H,T), !,
    del_dups(T,List2).
del_dups([H1|T1],[H2|T2]):-
    del_dups(T1,T2),
    H2 is H1.


% F
% list_perm(+L1,+L2)
list_perm(L1,L2):-
    del_one_list(L1,L2,L3),
    L3 = [].

% del_one_list(+ListElems,+List1,?List2)
del_one_list(_,[],[]).
del_one_list([H|T],List1,List2):-
    del_one(H,List1,List3),
    del_one_list(T,List3,List2).

% G
% replicate(+Amount,+Elem,?List)
replicate(0,_,[]).
replicate(Amount,Elem,List):-
    Amount2 is Amount - 1,
    replicate(Amount2,Elem,List2),
    List = [Elem|List2].

% H
% intersperse(+Elem, +List1, ?List2)
intersperse(_,[],[]).
intersperse(_,[A],[A]).
intersperse(Elem,[H1|T1],[H2|T2]):-
    intersperse(Elem,T1,T3),
    T2 = [Elem|T3],
    H2 = H1.