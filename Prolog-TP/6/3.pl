% A

pilot('Lamb').
pilot('Besenyei').
pilot('Chambliss').
pilot('MacLean').
pilot('Mangold').
pilot('Jones').
pilot('Bonhomme').
pilot('Max Verstappen').

team('Breitling').
team('Cobra').
team('Red Bull').
team('Mediterranean Racing Team').
team('Matador').

plain('MX2').
plain('Edge540').

circuits('Istanbul').
circuits('Budapest').
circuits('Porto').


belongs('Lamb','Breitling').
belongs('Besenyei','Red Bull').
belongs('Chambliss','Red Bull').
belongs('MacLean','Mediterranean Racing Team').
belongs('Mangold','Cobra').
belongs('Jones','Matador').
belongs('Bonhomme','Matador').

pilots('Lamb','MX2').
pilots('Besenyei','Edge540').
pilots('Chambliss','Edge540').
pilots('MacLean','Edge540').
pilots('Mangold','Edge540').
pilots('Jones','Edge540').
pilots('Bonhomme','Edge540').

pilot_won('Jones','Porto').
pilot_won('Mangold','Budapest').
pilot_won('Mangold','Istanbul').

gates('Istanbul',9).
gates('Budapest',6).
gates('Porto',5).

team_won(T,C):- pilot_won(P,C), belongs(P,T).


% B

/*
| ?- pilot_won(P,'Porto').
P = 'Jones' ? ;
no
| ?- team_won(T,'Porto').                                                           
T = 'Matador' ? ;
no
| ?- gates(C,N), N > 8.
C = 'Istanbul',
N = 9 ? ;
no
| ?- pilots(P,Plain), Plain \= 'Edge540'.
P = 'Lamb',
Plain = 'MX2' ? ;
no
| ?- pilot_won(P,C1), pilot_won(P,C2), C1 @< C2.
P = 'Mangold',
C1 = 'Budapest',
C2 = 'Istanbul' ? ;
no
| ?- pilot_won(P,'Porto'), pilots(P,Plain).
P = 'Jones',
Plain = 'Edge540' ? ;
no
*/
