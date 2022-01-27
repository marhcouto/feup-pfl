

% pascal(+N, ?Lines)
pascal((-1),[]).
pascal(N,Lines):-
    pascal_line(N,Line),
    NewN is N - 1,
    pascal(NewN,Lines2),
    append(Lines2,[Line],Lines).


% pascal_line(+N,?Line)
pascal_line(0,[1]).
pascal_line(N,List):-
    N > 0,
    pascal_line_aux(N,0,Temp),
    append(Temp,[1],List).

% pascal_line_aux(+N,+K,?List)
pascal_line_aux(N,N,[]).
pascal_line_aux(N,K,[H|T]):-
    NewK is K + 1,
    pascal_line_aux(N,NewK,T),
    pascal_elem(N,K,H).


% pascal_elem(+N,+K,-Elem)
pascal_elem(_,0,1).
pascal_elem(N,N,1).
pascal_elem(N,K,Elem):-
    K =< N,
    NewN is N - 1,
    NewK is K - 1,
    pascal_elem(NewN,K,Elem1),
    pascal_elem(NewN,NewK,Elem2),
    Elem is Elem1 + Elem2.
