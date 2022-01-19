% class(Course, ClassType, DayOfWeek, Time, Duration)
class(pfl, t, '1 Seg', 11, 1).
class(pfl, t, '4 Qui', 10, 1).
class(pfl, tp, '2 Ter', 10.5, 2).
class(lbaw, t, '1 Seg', 8, 2).
class(lbaw, tp, '3 Qua', 10.5, 2).
class(ltw, t, '1 Seg', 10, 1).
class(ltw, t, '4 Qui', 11, 1).
class(ltw, tp, '5 Sex', 8.5, 2).
class(fsi, t, '1 Seg', 12, 1).
class(fsi, t, '4 Qui', 12, 1).
class(fsi, tp, '3 Qua', 8.5, 2).
class(rc, t, '4 Qui', 8, 2).
class(rc, tp, '5 Sex', 10.5, 2).

% A)

same_day(UC1,UC2):-
    findall(Dia,(class(UC1,_,Dia,_,_), class(UC2,_,Dia,_,_)),[_|_]). 

same_day2(UC1,UC2):-
    bagof(D,(Tipo1,Tipo2,Hora1,Hora2,Duracao1,Duracao2)^(class(UC1,Tipo1,Dia,Hora1,Duracao1),class(UC2,Tipo2,Dia,Hora2,Duracao2)),[_|_]),
    UC1 \= UC2.

% B)

daily_courses(Day,Courses):-
    findall(UC,class(UC,Tipo,Day,Hora,Duration),Courses).

% C)

short_classes(L):-
    findall(UC-Dia/Hora,(class(UC,Tipo,Dia,Hora,Duracao), Duracao < 2),L).

% D)

course_classes(UC,L)-
    findall(Dia/Hora-Tipo, class(UC, Tipo, Dia, Hora,_),L).


% F)

schedule:-  
    setof(Dia-Hora-UC-Tipo-Duracao,class(UC,Tipo,Dia,Hora,Duracao),L),
    print_schedule(L).

print_schedule([]).
print_schedule([Dia-Hora-UC-Tipo-Duracao|Aulas]):-
    format("~a (~a) - ~a ~2f (~2f)", [UC,Tipo,Dia,Hora,Duracao]), nl,
    print_schedule(Aulas).