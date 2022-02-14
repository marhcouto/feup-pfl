:-use_module(library(lists)).


% Initial State


% initial_state(+Size,-GameState)
initial_state(Size,GameState):-
        Size > 0,
        Size mod 2 =:= 1,
        initial_state_aux(Size,Size,Board),
        GameState = -(Board,'p1').

% initial_state_aux(+Size,+N,-Board)
initial_state_aux(_,0,[]).
initial_state_aux(Size,N,Board):-
        N > 0,
        N1 is N - 1,
        initial_state_aux(Size,N1,Board1),
        decide_list(Size,N1,Board2),
        Board = [Board2|Board1].


% decide_list(+Size,+N,-List)
decide_list(Size,N,List):-
        N = 0,!,
        list_generator(Size,List,1).
decide_list(Size,N,List):-
        Size1 is Size - 1,
        N = Size1,!,
        list_generator(Size,List,2).
decide_list(Size,_,List):-
        list_generator(Size,List,0).



% board
% [[2,2,2,2,2,2,2,2,2],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[1,1,1,1,1,1,1,1,1]]