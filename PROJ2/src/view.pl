:-consult('utils.pl').


% print_valid_moves(+ListOfMoves)
print_valid_moves(ListOfMoves):-
    write('Valid moves:'),nl,
    print_list_ho(ListOfMoves,print_move).



% Display Game


% display_game(+GameState)
display_game(Board-Turn):-
        format('Turn: ~a', [Turn]), nl,
        display_game_aux(Board), nl.

% display_game_aux(+Board)
display_game_aux([]).
display_game_aux([H|T]):-
        write('| '), print_list_ho(H,write), nl,
        display_game_aux(T).

% print_move(+Move)
print_move(Origin-Destination):-
    Ox-Oy = Origin,
    Dx-Dy = Destination,
    format('(~d,~d)->(~d,~d)', [Ox,Oy,Dx,Dy]).
