% B

list_member(Elem,List):-
    append(_,[Elem | _],List).

% D

list_nth(N,List,Elem):-
    length(Prefix,N),
    append(Prefix,[Elem | _], List).