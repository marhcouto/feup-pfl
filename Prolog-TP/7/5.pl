% A

list_size([],0).
list_size([_|T],Size):-
    list_size(T,Size1),
    Size = Size1 + 1.

% B
% list_sum(+List, ?Sum)

% with tail recursion
list_sum(List,Sum):-
    list_sum_aux(List,Sum,0).

list_sum_aux([],Sum,Sum):-!.
list_sum_aux([H|T],Sum,Acc):-
    Sum1 is Acc + H,
    list_sum_aux(T,Sum,Sum1).

% C
% list_prod(+List,?Prod)
list_prod([],0).
list_prod([A],A).
list_prod([H|T],Prod):-
    list_prod(T,Prod1),
    Prod is Prod1 * H.

% D
% inner_product (+List1, +List2, ?Result)
inner_product([],L,L).
inner_product(L,[],L).
inner_product([A],[B],R):- 
    Temp is A * B,
    R = [Temp].
inner_product([H1|T1],[H2|T2],[RH|RT]):-
    inner_product(T1,T2,RT),
    RH is H1 * H2.

% E
% count(+Elem, +List, ?N)
count(_,[],0).
count(Elem,[Elem|T],N):-
    count(Elem,T,N1),
    N is 1 + N1.
count(Elem,[_|T],N):-
    count(Elem,T,N1),
    N is N1.
