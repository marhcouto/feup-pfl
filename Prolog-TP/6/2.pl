% A

leciona('Algoritmos',adalberto).
leciona('Bases de Dados',bernardete).
leciona('Compiladores',capitolino).
leciona('Estatistica',diogenes).
leciona('Redes',ermelinda).

frequenta('Algoritmos',alberto).
frequenta('Algoritmos',bruna).
frequenta('Algoritmos',cristina).
frequenta('Algoritmos',diogo).
frequenta('Algoritmos',eduarda).
frequenta('Bases de Dados',antonio).
frequenta('Bases de Dados',cristina).
frequenta('Bases de Dados',bruno).
frequenta('Bases de Dados',duarte).
frequenta('Bases de Dados',eduardo).
frequenta('Compiladores',bernardo).
frequenta('Compiladores',alberto).
frequenta('Compiladores',clara).
frequenta('Compiladores',diana).
frequenta('Compiladores',eurico).
frequenta('Estatistica',antonio).
frequenta('Estatistica',bruna).
frequenta('Estatistica',claudio).
frequenta('Estatistica',duarte).
frequenta('Estatistica',eva).
frequenta('Redes',alvaro).
frequenta('Redes',diana).
frequenta('Redes',beatriz).
frequenta('Redes',claudio).
frequenta('Redes',eduardo).

% B

/*
| ?- leciona(Uc, diogenes).
Uc = 'Estatistica' ? ;
no
| ?- leciona(_,felismina).                                                                  no    
| ?- frequenta(UC,claudio).
UC = 'Estatistica' ? ;
UC = 'Redes' ? ;
no
| ?- frequenta(_,dalmindo).
no
| ?- leciona(Uc,bernardete), frequenta(Uc,eduarda).
no
| ?- frequenta(Uc,alberto), frequenta(Uc,eduardo). 
no
*/

% C

aluno(P,A):- frequenta(Uc,A), leciona(Uc,P).
aluno_mutuo(X,Y,A):- aluno(X,A), aluno(Y,A).
colega(X,Y):- frequenta(Uc,X), frequenta(Uc,Y), X \= Y.
colega(X,Y):- leciona(_,X), leciona(_,Y), X \= Y.
alunos_varias_uc(X):- frequenta(UC1,X), frequenta(UC2,X), UC1 \= UC2.