% A

list_size([],0).
list_size([H|T],Size):-
    list_size(T,Size1),
    Size = Size1 + 1.