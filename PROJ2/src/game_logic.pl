% Move


% move(+GameState, +Move, -NewGameState)
move(GameState,Move,NewGameState):-
    valid_moves(GameState,ListOfMoves),
    member(Move,ListOfMoves),
    change_pawns(Move,GameState,NewGameState).


% change_pawns(+Move,+GameState,-NewGameState)
change_pawns(P1-P2,Board-Turn,NewBoard-NewTurn):-
    X1-Y1 = P1,
    X2-Y2 = P2,
    nth0(Y1,Board,List1),
    nth0(Y2,Board,List2),
    nth0(X1,List1,Horse),
    nth0(X2,List2,Empty),
    change_list(List2,X2,Horse,NewList2),
    change_list(List1,X1,Empty,NewList1),
    change_list(Board,Y2,NewList2,TempBoard),
    change_list(TempBoard,Y1,NewList1,NewBoard),
    change_turn(Turn,NewTurn).


% change_turn(+OldTurn,-NewTurn)
change_turn('p1','p2').
change_turn('p2','p1').


% change_list(+OldList,+Idx,+Val,-NewList)
change_list(OldList,Idx,Val,NewList):-
        length(OldList,Size),
        Idx < Size,
        Idx >= 0,
        change_list_aux(OldList,Size,Idx,0,Val,NewList).

change_list_aux(_,Size,_,Size,_,[]).
change_list_aux(OldList,Size,Idx,Idx,Val,NewList):-
        NewIdx is Idx + 1,
        change_list_aux(OldList,Size,Idx,NewIdx,Val,List),
        NewList = [Val|List].
change_list_aux(OldList,Size,Idx,CurIdx,Val,NewList):-
        nth0(CurIdx,OldList,Element),
        NewIdx is CurIdx + 1,
        change_list_aux(OldList,Size,Idx,NewIdx,Val,List),
        NewList = [Element|List].





% Valid Moves


% valid_moves(+GameState,-ListOfMoves)
valid_moves(Board-'p1',ListOfMoves):-
        find_horses(1,Board,Origins),
        findall(Moves,(member(Origin,Origins),possible_moves(Origin,Moves,Board)),List),
        append(List,ListOfMoves).
valid_moves(Board-'p2',ListOfMoves):-
        find_horses(2,Board,Origins),
        findall(Moves,(member(Origin,Origins),possible_moves(Origin,Moves,Board)),List),
        append(List,ListOfMoves).


% find_horses(+Val,+Board,-Positions)
find_horses(Val,Board,Positions):-
        findall(X-Y,(nth0(Y,Board,List), nth0(X,List,Val)), Positions).


% possible_moves(+Origin,-Moves,+Board)
possible_moves(Origin,Moves,Board):-
        \+ is_empty(Origin,Board),
        find_empty(Board,EmptyPositions),
        possible_moves_aux(Origin,PossiblePositions),
        findall((Origin)-Destination,(member(Destination,EmptyPositions), member(Destination,PossiblePositions)),Moves).

possible_moves_aux(X-Y,Destinations):-
        X2 is X+2,
        Y2 is Y+2,
        X1 is X+1,
        Y1 is Y+1,
        X4 is X-2,
        Y4 is Y-2,
        X3 is X-1,
        Y3 is Y-1,
        Destinations = [-(X2,Y1),-(X2,Y3),-(X4,Y1),-(X4,Y3),-(X1,Y2),-(X1,Y4),-(X3,Y2),-(X3,Y4)].


% find_empty(+Board,-Positions)
find_empty(Board,Positions):-
        findall(X-Y,(nth0(Y,Board,List), nth0(X,List,0)), Positions).


% is_empty(+Position,+Board)
is_empty(X-Y,Board):-
        nth0(Y,Board,List),
        nth0(X,List,0).



% GameOver

% game_over(+GameState,-Winner)
game_over(Board-Turn,Winner):-
        is_check(Board-Turn,Status),
        Status = 'checkmate',
        Winner = Turn.
        

% is_check(+GameState,-Status)
is_check(Board-Turn,Status):-
        nth0(4,Board,List),
        nth0(4,List,MiddleHouse),
        is_check_aux(MiddleHouse,Turn,Status).


% is_check_aux(+MiddleHouse,+Turn,-Status)
is_check_aux(1,'p1','checkmate').
is_check_aux(2,'p2','checkmate').
is_check_aux(1,'p2','check').
is_check_aux(2,'p1','check').




