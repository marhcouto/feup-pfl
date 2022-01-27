:-use_module(library(between)).
:-use_module(library(lists)).

%player(Name, UserName, Age).
player('Danny', 'Best Player Ever', 27).
player('Annie', 'Worst Player Ever', 24).
player('Harry', 'A-Star Player', 26).
player('Manny', 'The Player', 14).
player('Jonny', 'A Player', 16).

%game(Name, Categories, MinAge)
game('5 ATG', [action, adventure, open-world, multiplayer], 18).
game('Carrier Shift: Game Over', [action, fps, multiplayer, shooter], 16).
game('Duas Botas', [action, free, strategy, moba], 12).

%played(Player, Game, HoutsPlayed, PercentUnlocked)
:-dynamic played/4.
played('Best Player Ever', '5 ATG', 3, 83).
played('Worst Player Ever', '5 ATG', 52, 9).
played('The Player', 'Carrier Shift: Game Over', 44, 22).
played('A Player', 'Carrier Shift: Game Over', 48, 24).
played('A-Star Player', 'Duas Botas', 37, 16).
played('Best Player Ever', 'Duas Botas', 33, 22).

achievedALot(Player) :- 
	played(Player, _, _, PercentUnlocked),
	PercentUnlocked >= 80.
	
isAgeAppropriate(Name, Game) :- 
	player(Name, _, Age),
	game(Game, _, MinAge),
	Age >= MinAge.

timePlayingGames(Player, Games, ListOfTimes, SumTimes) :- 
	assert(list_times([])),
	assert(sum_times(0)),
	timePlayingGames_aux(Player, Games),
	retract(list_times(ListOfTimes)),
	retract(sum_times(SumTimes)).
	
timePlayingGames_aux(Player, [Game|_]) :- 
	played(Player, Game, Time, _),
	retract(list_times(LT)),
	retract(sum_times(ST)),
	NST is ST + Time,
	append(LT, [Time], NLT),
	asserta(list_times(NLT)),
	asserta(sum_times(NST)),
	fail.
timePlayingGames_aux(Player, [Game|T]) :- 
	played(Player, Game, _, _),! , 
	timePlayingGames_aux(Player, T).
timePlayingGames_aux(Player, [_|T]) :- 
	!,
	retract(list_times(LT)),
	append(LT, [0], NLT),
	asserta(list_times(NLT)),
	timePlayingGames_aux(Player, T).
timePlayingGames_aux(_, []).

listGamesOfCategory(Cat) :- 
	game(Name, Categories, MinAge),
	append(_, [Cat|_], Categories),
	format('~s (~d)~n', [Name, MinAge]),
	fail.
listGamesOfCategory(_).

updatePlayer(Player, Game, Hours, Percentage) :- 
	retract(played(Player, Game, OldHours, OldPercentage)),
	NHours is Hours + OldHours,
	NPer is Percentage + OldPercentage,
	asserta(played(Player, Game, NHours, NPer)).
updatePlayer(Player, Game, Hours, Percentage) :- asserta(played(Player, Game, Hours, Percentage)).

fewHours(Player, Games) :- 
	asserta(list_games([])),
	fewHours_aux(Player),
	retract(list_games(Games)).
	
fewHours_aux(Player) :- 
	played(Player, Game, Time, _),
	Time < 10,
	retract(list_games(LG)),
	append(LG, [Game], NLG),
	asserta(list_games(NLG)),
	fail.
fewHours_aux(_).

ageRange(MinAge, MaxAge, Players) :- findall(PlayerName, (player(PlayerName, _, Age), between(MinAge, MaxAge, Age)), Players).

averageAge(Game, AverageAge) :- 
	findall(UserName-PlayerAge, (played(UserName, Game, _, _), player(_, UserName, PlayerAge)), UNSPlayersAge),
	sort(UNSPlayersAge, PlayersAge),
	length(PlayersAge, LPA),
	sum(PlayersAge, 0, Sum),
	AverageAge is Sum/LPA.

sum([], Acc, Acc).	
sum([_-Age|T], Acc, Sum) :- 
	NAcc is Acc + Age,
	sum(T, NAcc, Sum).
	
mostEffectivePlayers(Game, Players) :- 
	findall(Eff-Player, (played(Player, Game, Time, Percentage), Eff is Percentage / Time), PlayerEff),
	sort(PlayerEff, RevSortedPlayerEff),
	reverse(RevSortedPlayerEff, SortedPlayerEff),
	[Top-_|_] = SortedPlayerEff,
	include(top(Top), SortedPlayerEff, UnfilPlayers),
	filterEffectiveness(UnfilPlayers, [], Players).

top(Top, Top-_).

filterEffectiveness([], Acc, Filtered) :- reverse(Acc, Filtered).
filterEffectiveness([E-P|T], Acc, Filtered) :- filterEffectiveness(T, [P|Acc], Filtered).

/*
	Verifica se o jogador X jogou um jogo para o qual nao tinha idade. transgressedRules
	A funcionalidade do cut é apenas para desempenho e evita a pesquisa por outros jogadores com o mesmo nome de utilizador.
*/

whatDoesItDo(X) :- 
	player(Y, X, Z), !,
	\+ ( played(X, G, L, M),
		game(G, N, W),
		W > Z
	).
	

%Pergunta 11 - Guardaria cada dado num predicado distance(Row, Column, Distance), mas apenas para os casos Row <= Column, para os outros casos haveria uma regra que faria com que Row fosse trocada com column.

matrix([[0, 8, 8, 7, 7], [8, 0, 2, 4, 4], [8, 2, 0, 3, 3], [7, 4, 3, 0, 1], [7, 4, 3, 1, 0]]).

areClose(MaxDist, MatDist, Pares) :- 
	length(MatDist, Size),
	findall(Row/Column, (
		between(1, Size, Row),
		between(1, Row, Column),
		Row \= Column,
		nth1(Row, MatDist, MRow),
		nth1(Column, MRow, Dist),
		Dist =< MaxDist
	), Pares).
	
/*
	Podemos definir a arvore como tendo o seguinte tipos de então a arvore anterior seria representada como
*/

get_tree(T) :- T = binary_tree(
	1, 
	binary_tree(
		2,
		binary_tree(
			3,
			binary_tree(
				4,
				servia,
				franca
			),
			binary_tree(
				5,
				binary_tree(
					6,
					binary_tree(
						7,
						australia,
						binary_tree(
							8,
							binary_tree(9, sta_helena, anguila),
							georgia_do_sul
						)
					)
				),
				reino_unido
			)
		),
		binary_tree(
			10,
			binary_tree(11, niger, india),
			irlanda
		)
	),
	brasil
).

distance(C1, C2, binary_tree(ID, Left, Right), Distancia).
	
find(C, binary_tree(_, C, _)).
find(C, binary_tree(_, _, C)).
find(C, binary_tree(_, Left, _)) :- find(C, Left).
find(C, binary_tree(_, _, Right)) :- find(C, Right).

altura(binary_tree(_, L, R), H) :- 
	altura(L, HL),
	altura(R, HR),
	!,
	H is 1 + max(HL, HR).
altura(binary_tree(_, _, _), 0) :- !.