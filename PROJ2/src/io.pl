
% Gets a move from user input
% get_move(-Move)
get_move(Move):-
    nl, nl, write('Choose your move (format: (Integer corresponding to the X or Y of the coordinate).)'),nl,
    write('Origin X:'), read(Ox),
    write('Origin Y:'), read(Oy),
    write('Destination X:'), read(Dx),
    write('Destination Y:'), read(Dy),
    Origin = -(Ox,Oy),
    Destination = -(Dx,Dy),
    Move = -(Origin,Destination).



% Congratulating message on the winner of the game
% congratulate(+Winner)
congratulate(Winner):-
    format('~a won the game.',[Winner]).


