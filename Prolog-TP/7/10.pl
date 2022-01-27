% A
% is_ordered(+List)
is_ordered([]).
is_ordered([_]).
is_ordered([H|T]):-
    is_ordered_aux(T,H).

% is_ordered_aux(+List,Num)
is_ordered_aux([],_).
is_ordered_aux([H|T],Num):-
    H >= Num,
    is_ordered_aux(T,H).


% B
% insert_ordered(+Value, +List1, ?List2)
insert_ordered(Value,[],[Value]).
insert_ordered(Value,[H1|T1],[H2|T2]):-
    Value > H1,!,
    insert_ordered(Value,T1,T2),
    H2 is H1.
insert_ordered(Value,List1,[Value|List1]).


% C
% insert_sort(+List, ?OrderedList)
insert_sort(List,OrderedList):-
    insert_sort_aux(List,[],OrderedList).
insert_sort_aux([],Acc,Acc).
insert_sort_aux([H|T],Acc,OrderedList):-
    insert_ordered(H,Acc,Acc2),
    insert_sort_aux(T,Acc2,OrderedList).

