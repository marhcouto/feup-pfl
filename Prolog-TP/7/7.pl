
% A
% list_append(?L1, ?L2, ?L3)
list_append([],L2,L2).
list_append(L1,[],L1).
list_append([H1|T1],L2,[H3|T3]):-
    H3 = H1,
    list_append(T1,L2,T3).

% B

list_member(Elem,List):-
    append(_,[Elem | _],List).

% D

list_nth(N,List,Elem):-
    length(Prefix,N),
    append(Prefix,[Elem | _], List).