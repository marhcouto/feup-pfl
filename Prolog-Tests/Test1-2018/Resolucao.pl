:-use_module(library(lists)).
:-use_module(library(between)).

%airport(Name, ICAO, Country)
airport('Aeroporto Francisco Sá Carneiro', 'LPPR', 'Portugal').
airport('Aeroporto Humberto Delgado', 'LPPT', 'Portugal').
airport('Aeropuerto Adolfo Suárez Madrid-Barajas', 'LEMD', 'Spain').
airport('Aéroport de Paris-Charles-de-Gaulle Roissy Airport', 'LFPG', 'France').
airport('Aeroporto Internazionale di Roma-Fiumicino - Leonardo da Vinci', 'LIRF', 'Italy').

%company(ICAO, Name, Year, Country)
company('TAP', 'TAP Air Portugal', 1945, 'Portugal').
company('RYR', 'Ryanair', 1984, 'Ireland').
company('AFR', 'Société Air France', 1933, 'France').
company('BAW', 'British Airways', 1974, 'United Kingdom').

%flight(Designation, Origin, Destination, DepartureTime, Duration, Company).
flight('TP1923', 'LPPR', 'LPPT', 1115, 55, 'TAP').
flight('TP1968', 'LPPT', 'LPPR', 2235, 55, 'TAP').
flight('TP842', 'LPPT', 'LIRF', 1450, 195, 'TAP').
flight('TP843', 'LIRF', 'LPPT', 1935, 195, 'TAP').
flight('FR5483', 'LPPR', 'LEMD', 630, 105, 'RYR').
flight('FR5484', 'LEMD', 'LPPR', 1935, 105, 'RYR').
flight('AF1024', 'LFPG', 'LPPT', 940, 155, 'AFR').
flight('AF1025', 'LPPT', 'LFPG', 1310, 155, 'AFR').

%short(+Flight)
short(Flight) :- flight(Flight, _, _, _, Duration, _), Duration =< 90.

%shorter(+Flight1, +Flight2, -ShorterFlight)
shorter(Flight1, Flight2, Flight1) :- 
	flight(Flight1, _, _, _, Duration1, _),
	flight(Flight2, _, _, _, Duration2, _),
	Duration1 < Duration2.
shorter(Flight1, Flight2, Flight2) :- 
	flight(Flight1, _, _, _, Duration1, _),
	flight(Flight2, _, _, _, Duration2, _),
	Duration1 > Duration2.
	
%arrivalTime(+Flight, -ArrivalTime)
arrivalTime(Flight, ArrivalTime) :- 
	flight(Flight, _, _, Departure, Duration, _),
	DepHour is Departure div 100,
	OverMin is (Departure rem 100) + Duration,
	ArrMin is OverMin rem 60,
	ArrHour is (DepHour + (OverMin div 60)) * 100,
	ArrivalTime is ArrHour + ArrMin.
	
%countries(+Company, -ListOfCountries)
countries(Company, ListOfCountries) :- retract(paises_opera(_)), !, countries(Company, ListOfCountries).
countries(Company, ListOfCountries) :-
	asserta(paises_opera([])),
	countries_aux(Company),
	retract(paises_opera(LDups)),
	sort(LDups, ListOfCountries).
countries_aux(Company) :-
	opera(Company, Country),
	retract(paises_opera(L)),
	asserta(paises_opera([Country|L])),
	fail.
countries_aux(_).

%opera(?Company, ?Country)
opera(Company, Country) :-
	flight(_, Dep, _, _, _, Company),
	airport(_, Dep, Country).
opera(Company, Country) :-
	flight(_, _, Arr, _, _, Company),
	airport(_, Arr, Country).
	
pairableFlights :- 
	flight(CodeFirst, _, Intermidiate, _, _, _),
	flight(CodeSecond, Intermidiate, _, DepartureSecond, _, _),
	arrivalTime(CodeFirst, ArrivalFirst),
	ArrivalFirstMin is (ArrivalFirst rem 100) + (ArrivalFirst div 100) * 60,
	DepartureSecondMin is (DepartureSecond rem 100) + (DepartureSecond div 100) * 60,
	Diference is abs(DepartureSecondMin - ArrivalFirstMin),
	Diference >= 30,
	Diference =< 90,
	format('~s - ~s \\ ~s', [Intermidiate, CodeFirst, CodeSecond]),
	nl,
	fail.
pairableFlights.

%timeToMinutes(+FlightTime, -FlightMinutes)
timeToMinutes(FT, FM) :- 
	FM is (FT rem 100) + (FT div 100) * 60.

rev([], Acc, Acc).
rev([H|T], Acc, RevL) :- rev(T, [H|Acc], RevL).

%tripDays(+Trip, +Time, +FlightTimes, -Days)
tripDays([Dep, Arr|T], Time, FlightTimes, Days) :- 
	airport(_, DepA, Dep),
	airport(_, ArrA, Arr),
	flight(_, DepA, ArrA, DepTime, Duration, _),
	DepTime >= Time,
	tripDays_aux([Arr|T], [DepTime], FlightTimes, Duration, Days).

tripDays_aux([_], FTAcc, FlightTimes, DaysAcc, Days) :-
	Days is (DaysAcc div 60) div 24,
	rev(FTAcc, [], FlightTimes).
tripDays_aux([Dep, Dest|TDest], [LastFD|TD], FlightTimes, DaysAcc, Days) :- 
	airport(_, DepA, Dep),
	airport(_, DestA, Dest),
	flight(_, DepA, DestA, Time, Duration, _),
	timeToMinutes(Time, TimeMin),
	timeToMinutes(LastFD, LastFDMin),
	TimeDiff is abs(TimeMin - LastFDMin),
	TimeDiff >= 30,
	NDaysAcc is DaysAcc + TimeMin + TimeDiff,
	tripDays_aux([Dest|TDest], [Time, LastFD|TD], FlightTimes, NDaysAcc, Days).

%avgFlightLengthFromAirport(+Airport, -AvgLength)
avgFlightLengthFromAirport(Airport, AvgLength) :- 
	findall(Duration, flight(_, Airport, _, _, Duration, _), ListOfFlights),
	sum(ListOfFlights, 0, TotalDur),
	length(ListOfFlights, NFlight),
	AvgLength is TotalDur / NFlight.
	
sum([], Acc, Acc).
sum([H|T], Acc, Sum) :- 
	NAcc is Acc + H,
	sum(T, NAcc, Sum).
	
%mostInternational(-ListOfCompanies)
mostInternational(ListOfCompanies) :- 
	findall(Company-NCountries, (company(Company, _, _, _), countries(Company, Countries), length(Countries, NCountries)), ListOfCountries),
	max_member(c_comp, MaxNCountriesCompany, ListOfCountries),
	_-MaxNCountries = MaxNCountriesCompany,
	removeN(MaxNCountries, ListOfCountries, [], ListOfCompanies).
	
	
c_comp(_-NCountries1, _-NCountries2) :- NCountries1 < NCountries2.
removeN(_, [], Acc, Acc).
removeN(MaxNCountries, [Company-MaxNCountries|T], Acc, List) :- removeN(MaxNCountries, T, [Company|Acc], List).
removeN(MaxNCountries, [_|T], Acc, List) :- removeN(MaxNCountries, T, Acc, List).

%Ex 9 - Basta remover o cut, assim por backtrack o select vai encontrar outros elementos que satisfacam o predicado
dif_max_2(X, Y) :- X < Y, X >= Y-2.
make_pairs(L, P, [X-Y|Zs]) :- 
	select(X, L, L2),
	select(Y, L2, L3),
	G =.. [P, X, Y], G,
	make_pairs(L3, P, Zs).
make_pairs(L, P, Zs) :- 
	select(X, L, L2),
	select(Y, L2, L3),
	G =.. [P, X, Y], \+G,
	make_pairs(L3, P, Zs).
make_pairs([_], _, []).
make_pairs([], _, []).

make_max_pairs(L, P, S) :- 
	findall(Pair, (make_pairs(L, P, Pair)), ListOfPairs),
	max_len(ListOfPairs, -1000, MaxLen),
	find_first(ListOfPairs, MaxLen, S).
	
find_first([List|T], MaxLen, List) :- 
	length(List, MaxLen).
find_first([_|T], MaxLen, List) :- find_first(T, MaxLen, List).
	
	
max_len([], Acc, Acc).
max_len([H|T], Acc, MaxLen) :- 
	length(H, Len),
	Len > Acc,
	max_len(T,  Len, MaxLen).
max_len([_|T], Acc, MaxLen) :- max_len(T, Acc, MaxLen).


valid_move(FR-FC, TR-FC) :- 
	board_size(Size),
	N is Size - 1,
	TR is FR + 1,
	between(0, N, TR).
valid_move(FR-FC, FR-TC) :- 
	board_size(Size),
	N is Size - 1,
	TC is FC + 1,
	between(0, N, TC).
	
valid_move(FR-FC, TR-TC) :- 
	board_size(Size),
	N is Size - 1,
	TR is FR + 1,
	TC is FC + 1,
	between(0, N, TC),
	between(0, N, TR).

whitoff(N, W) :- 
	asserta(board_size(N)),
	findall(Moves, (whitoff_aux(Moves), length(Moves, LM), Rem is LM rem 2, Rem \= 0), W),
	retract(board_size(_)).

whitoff_over(N-N) :- 
	board_size(Size),
	N is Size - 1.

whitoff_aux(Moves) :- 
	board_size(Size),
	N is Size - 1,
	between(0, N, InitR),
	between(0, N, InitC),
	find_win(InitR-InitC, [InitR-InitC], Moves).
	
find_win(R-C, Acc, Acc) :- whitoff_over(R-C).
find_win(R-C, Acc, Moves) :- 
	valid_move(R-C, TR-TC),
	find_win(TR-TC, [TR-TC|Acc], Moves).
	
	