
% list_generator(+Size,-List,+Elem).
list_generator(0,[],_).
list_generator(Size,List,Elem):-
        Size > 0,
        NewSize is Size - 1,
        list_generator(NewSize,NewList,Elem),
        List = [Elem|NewList].


% print_list_ho(+List,+Func)
print_list_ho([],_).
print_list_ho([H|T],Func):-
    call(Func, H),   
    write(' | '),
    print_list_ho(T,Func).