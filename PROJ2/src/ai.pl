:-consult('game_logic.pl').

evaluateBord(Board-'p1',Score):-
    is_check(Board-'p1',Status),
    Status = 'check',
    Score is 300.

% evaluateBord(+Val,+GameState,-Score)
evaluateBord(Board-'p1',Score):-
    find_horses(1,Board,Positions),
    length(Positions,Size),
    Score1 is Size,
    valid_moves(Board-'p1',Moves),
    length(Moves,SizeMoves),
    Score2 is SizeMoves,
    Score is Score1 + Score2.

evaluateBord(Board-'p2',Score):-
    is_check(Board-'p2',Status),
    Status = 'check',
    Score is 300.    

evaluateBord(Board-'p2',Score):-
    find_horses(2,Board,Positions),
    length(Positions,Size),
    Score1 is Size,
    valid_moves(Board-'p2',Moves),
    length(Moves,SizeMoves),
    Score2 is SizeMoves,
    Score is Score1 + Score2.
    


