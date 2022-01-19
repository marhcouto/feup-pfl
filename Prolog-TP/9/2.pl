:-use_module(library(lists)).

flight(porto, lisbon, tap, tp1949, 1615, 60).
flight(lisbon, madrid, tap, tp1018, 1805, 75).
flight(lisbon, paris, tap, tp440, 1810, 150).
flight(lisbon, london, tap, tp1366, 1955, 165).
flight(london, lisbon, tap, tp1361, 1630, 160).
flight(porto, madrid, iberia, ib3095, 1640, 80).
flight(madrid, porto, iberia, ib3094, 1545, 80).
flight(madrid, lisbon, iberia, ib3106, 1945, 80).
flight(madrid, paris, iberia, ib3444, 1640, 125).
flight(madrid, london, iberia, ib3166, 1550, 145).
flight(london, madrid, iberia, ib3163, 1030, 140).
flight(porto, frankfurt, lufthansa, lh1177, 1230, 165).


direct_flight(Ni,Nf,F):-
    flight(Ni,Nf,_,F,_,_).

% A)
get_all_nodes(L):-
    setof(Airport,source_or_dest(Airport),L).

source_or_dest(N):- direct_flight(N,_,_).
source_or_dest(N):- direct_flight(_,N,_).

% C
find_flights(O,D,Flights):-
    dfs([O],D,Flights).

dfs([D|_],D,[]).
dfs([N|T],D,[F|Flights]):-
    direct_flight(N,X,F),
    \+ member(X,[N|T]),
    dfs([X,N|T],D,Flights).

find_flights_breadth(Ni,Nf,Fs):-   
    get_all_nodes(Nodes),
    member(Ni,Nodes),
    bfs([[Ni]-[]],Nf,FsInv),
    reverse(FsInv,Fs).

bfs([[Nf|_]-Fs|_],Nf,Fs).
bfs([[Na|T]-Fs|Ps],Nf,Sol):-
    findall([Nb,Na|T]-[F|Fs],(direct_flight(Na,Nb,F), \+member(Nb,[Na|T])), Ps1),
    append(Ps,Ps1,Ps2),
    bfs(Ps2,Nf,Sol).