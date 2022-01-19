% A)

print_n(0,_).
print_n(N,S):-
    N > 0,
    write(S),
    N1 is N-1,
    print_n(N1,S).

% D)

read_number(X):-

read_number_aux(X,0).
read_number_aux(X,Acc):-
    get_code(C),
    C > 47,
    C < 58,
    !, 
    Acc1 is Acc*10 + (C - 48),
    read_number_aux(X,Acc1).
read_number_aux(X,X).


read_until_between(Min,Max,Val):-
    repeat,
    read_number(Val),
    Val >= Min,
    Val =< Max,
    !.