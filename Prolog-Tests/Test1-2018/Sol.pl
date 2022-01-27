:-use_module(library(lists)).
:-use_module(library(between)).

airport('Aeroporto Francisco Sá Carneiro','LPPR','Portugal').
airport('Aeroporto Humberto Delgado','LPPT','Portugal').
airport('Aeropuerto Adolfo Suárez Madrid-Barajas','LEMD','Spain').
airport('Aéroport de Paris-Charles-de-Gaulle Roissy Airport','LFPG','France').
airport('Aeroporto Internazionale di Roma-Fiumicino - Leonardo da Vinci','LIRF','Italy').


company('TAP','TAP Air Portugal',1945,'Portugal').
company('RYR','Ryanair',1984,'Ireland').
company('AFR','Société Air France, S.A.',1933,'France').
company('BAW','British Airways',1974,'United Kingdom').


flight('TP1923','LPPR','LPPT',1115,55,'TAP').
flight('TP1968','LPPT','LPPR',2235,55,'TAP').
flight('TP842','LPPT','LIRF',1450,195,'TAP').
flight('TP843','LIRF','LPPT',1935,195,'TAP').
flight('FR5483','LPPR','LEMD',630,105,'RYR').
flight('FR5484','LEMD','LPPR',1935,105,'RYR').
flight('AF1024','LFPG','LPPT',940,155,'AFR').
flight('AF1025','LPPT','LFPG',1310,155,'AFR').


% 3
arrivalTime(Flight,ArrivalTime):-
    flight(Flight,_,_,Dep,Dur,_),
    Hours is Dep // 100,
    Mins is Dep rem 100,
    NewMins is Mins + Dur,
    MoreHours is NewMins // 60,
    NewNewMins is NewMins rem 60,
    NewHours is (Hours + MoreHours) rem 24,
    NewNewHours is NewHours * 100,
    ArrivalTime is NewNewHours + NewNewMins.

% 4
%countries(+Company, -ListOfCountries)
countries(Company, ListOfCountries) :- retract(paises_opera(_)), !, countries(Company, ListOfCountries).
countries(Company, ListOfCountries) :-
	asserta(paises_opera([])),
	countries_aux(Company),
	retract(paises_opera(LDups)),
	sort(LDups, ListOfCountries).

countries_aux(Company) :-
	company_country(Company, Country),
	retract(paises_opera(L)),
	asserta(paises_opera([Country|L])),
	fail.
countries_aux(_).

company_country(Company,Country):-
    flight(_,_,Airport,_,_,Company),
    airport(_,Airport,Country).
company_country(Company,Country):-
    flight(_,Airport,_,_,_,Company),
    airport(_,Airport,Country).


% 5
pairableFlights:-
    flight(Flight1,_,Arr,_,_,_),
    flight(Flight2,Arr,_,DepTime,_,_),
    Flight1 \= Flight2,
    arrivalTime(Flight1,ArrivalTime),
    ArrivalFirstMin is (ArrivalTime rem 100) + (ArrivalTime div 100) * 60,
	DepartureSecondMin is (DepTime rem 100) + (DepTime div 100) * 60,
	Diference is abs(DepartureSecondMin - ArrivalFirstMin),
	Diference >= 30,
	Diference =< 90,
    format('~a - ~a \\ ~a', [Arr,Flight1,Flight2]), nl,
    fail.
pairableFlights.


% 6
tripDays(Trip,Time,FlighTimes,Days):-   
    tripDaysAux(Trip,Time,FlighTimes,Days,0).

tripDaysAux([P1,P2],Time,[H,H2|T],Days,DaysAcc):-
    airport(_,Airport1,P1),
    airport(_,Airport2,P2),
    flight(Flight,Airport1,Airport2,Dep,_,_),
    DepMins is ((Dep // 100) * 60) + (Dep rem 100),
    TimeMins is ((Time // 100) * 60) + (Time rem 100),
    Dif is DepMins - TimeMins, getDays(Dif,DaysAcc,NewDaysAcc),
    arrivalTime(Flight,ArrivalTime),
    H is Dep, H2 is ArrivalTime, T = [], Days is NewDaysAcc.

tripDaysAux([P1,P2|TC],Time,[H|T],Days,DaysAcc):-
    airport(_,Airport1,P1),
    airport(_,Airport2,P2),
    flight(Flight,Airport1,Airport2,Dep,_,_),
    DepMins is ((Dep // 100) * 60) + (Dep rem 100),
    TimeMins is ((Time // 100) * 60) + (Time rem 100),
    Dif is DepMins - TimeMins, getDays(Dif,DaysAcc,NewDaysAcc),
    H is Dep,
    arrivalTime(Flight,ArrivalTime),
    tripDaysAux([P2|TC],ArrivalTime,T,Days,NewDaysAcc).



getDays(Dif,Days,NewDays):- Dif =< 30, NewDays is Days.
getDays(Dif,Days,NewDays):- Dif > 30, NewDays is Days + 1.
getDays(Dif,Days,NewDays):- Dif < 0, NewDays is Days + 1.

% 7

avgFlightLengthFromAirport(Airport,AvgLength):-
    findall(Duration,flight(_,Airport,_,_,Duration,_),List),
    write(List), nl,
    sumlist(List,Sum),
    length(List,Size),
    AvgLength is Sum / Size.


% 8
mostInternational(Companies):-
    findall(Company-NoCountries,(company(Company,_,_,_), countries(Company,ListOfCountries), length(ListOfCountries,NoCountries)),List),
    max_member(comp,Company-Max,List),
    findall(Company2,(member(Company2-Score,List),Score =:= Max), Companies).

comp(_-Score1,_-Score2):- Score1 < Score2.

% 9
make_pairs(L,P,[X-Y|Zs]):-
    select(X,L,L2),
    select(Y,L2,L3),
    G =.. [P,X,Y], G,
    make_pairs(L3,P,Zs).
make_pairs([],_,[]).

dif_max_2(X,Y):- X < Y, X >= Y - 2.

% 10
make_pairs_2([],_,[]).
make_pairs_2([_],_,[]).
make_pairs_2(L,P,[X-Y|Zs]):-
    select(X,L,L2),
    select(Y,L2,L3),
    G =.. [P,X,Y], G,
    make_pairs_2(L3,P,Zs).
make_pairs_2(L,P,Zs):-
    select(X,L,L2),
    select(Y,L2,L3),
    G =.. [P,X,Y], \+G,
    make_pairs_2(L3,P,Zs).


% 11
make_max_pairs(L,P,S):-
    findall(ListOfPairs,make_pairs_2(L,P,ListOfPairs),ListsOfPairs),
    max_member(S,ListsOfPairs).
