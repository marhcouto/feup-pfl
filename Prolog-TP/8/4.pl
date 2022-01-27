% A)

print_n(0,_).
print_n(N,S):-
    N > 0,
    write(S),
    N1 is N-1,
    print_n(N1,S).

% B)
% print_text(+Text, +Symbol, +Padding)
print_text(Text,Symbol,Padding):-
    write(Symbol), 
    print_char(Padding,' '),
    format(Text,[]),
    print_char(Padding,' '),
    write(Symbol).


% print_char(+Times,+Char)
print_char(0,_).
print_char(Times,Char):-
    write(Char), 
    NewTimes is Times - 1,
    print_char(NewTimes,Char).

% C)
% print_banner(+Text, +Symbol, +Padding)
print_banner(Text,Symbol,Padding):-
    length(Text,Size),
    print_char(Padding*2 + Size + 2,Symbol), nl,
    write(Symbol), print_char(Padding*2 + Size,' '), write(Symbol), nl,
    print_text(Text,Symbol,Padding), nl,
    write(Symbol), print_char(Padding*2 + Size,' '), write(Symbol), nl,
    print_char(Padding*2 + Size + 2,Symbol).
    


% D)

read_number(X):-
    read_number_aux(X,0).

read_number_aux(X,Acc):- 
    get_code(C),
    C >= 48,
    C =< 57,
    !,
    Acc1 is 10*Acc + (C - 48),
    read_number_aux(X,Acc1).
read_number_aux(X,X).


% E)
% read_until_between(+Min, +Max, -Value)
read_until_between(Min,Max,Value):-
    repeat,
    read_number(Value),
    Value >= Min,
    Value =< Max,
    !.

% F)
% read_string(-X)
read_string([H|T]):-
    get_code(C), 
    C \= 10, !,
    H = C,
    read_string(T).
read_string(_).


% G)
% banner
banner:-
    read_string(Text),
    get_char(Symbol), Symbol \= '\n',
    get_code(_),
    read_number(Padding),
    print_banner(Text,Symbol,Padding).


% I)
% oh_christmas_tree(+N)
oh_christmas_tree(N):-
    N rem 2 =:= 1,
    oh_christmas_tree_aux(1,N).


oh_christmas_tree_aux(CurN,N):-
    CurN > N, !,
    White is (N - 1) // 2,
    print_n(White,' '),
    print_n(1,'*'),
    print_n(White,' '),nl.
oh_christmas_tree_aux(CurN,N):-
    N >= CurN,
    White is (N - CurN) // 2,
    print_n(White,' '),
    print_n(CurN,'*'),
    print_n(White,' '), nl,
    NewN is CurN + 2,
    oh_christmas_tree_aux(NewN,N).