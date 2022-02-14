:-consult('board.pl').
:-consult('game_logic.pl').
:-consult('view.pl').
:-consult('io.pl').
:-consult('ai.pl').

% Clear screen
cls:-
    write('\33\[2J').

% Starts the game
% play
play:-
    cls,
    initial_state(9,G),
    main_cycle(G).

% main_cycle(+GameState)
main_cycle(GameState):-
    game_over(GameState,Winner), !,
    congratulate(Winner).

main_cycle(GameState):-
    display_game(GameState),
    valid_moves(GameState,ValidMoves),
    print_valid_moves(ValidMoves),
    get_move(Move),
    move(GameState,Move,NewGameState),
    !,
    evaluateBord(NewGameState,Score),
    format('Score: ~d', [Score]),
    % cls,
    main_cycle(NewGameState).