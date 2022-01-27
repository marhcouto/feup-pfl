:-use_module(library(lists)).

jogo(1,sporting,porto,1-2).
jogo(1,maritimo,benfica,2-0).
jogo(2,sporting,benfica,0-2).
jogo(2,porto,maritimo,1-0).
jogo(3,maritimo,sporting,1-1).
jogo(3,benfica,porto,0-2).
treinadores(porto,[[1-3]-sergio_conceicao]).
treinadores(sporting,[[1-2]-silas,[3-3]-ruben_amorim]).
treinadores(benfica,[[1-3]-bruno_lage]).
treinadores(maritimo,[[1-3]-jose_gomes]).


% 1
% n_treinadores(?Equipa, ?Numero)
n_treinadores(Equipa,Numero):-
    treinadores(Equipa,Treinadores),
    length(Treinadores,Numero).


% 2
% n_jornadas_treinador(?Treinador, ?NumeroJornadas)
n_jornadas_treinador(Treinador,NumeroJornadas):-
    treinadores(_,Lista),
    member([N1-N2]-Treinador,Lista),
    NumeroJornadas is N2 - N1 + 1.


% 3
% ganhou(?Jornada, ?EquipaVencedora, ?EquipaDerrotada)
ganhou(Jornada,EquipaVencedora,EquipaDerrotada):-
    jogo(Jornada,EquipaVencedora,EquipaDerrotada,A-B),
    A > B.
ganhou(Jornada,EquipaVencedora,EquipaDerrotada):-
    jogo(Jornada,EquipaDerrotada,EquipaVencedora,A-B),
    A < B.


% 4 R: C
% 5 R: E


% 6
:-op(200, xfx, venceu).
:-op(180, fx, o).

o X:- treinadores(X,_).

X venceu Y:-
    ganhou(_,X,Y).


% 7
% A
% O predicado predXY(?N,+A,+B) passa se N está entre A e B. Faz isto verificando primeiramente se A é igual a N. Se não o for e A for diferente de B, vai efetuar uma chamada recursiva onde o novo valor de A se aproxima do de B por uma unidade. Isto é feito através do uso do predicado sign/1. Se B for maior que A, o resultado do predicado é 1 e A é incrementado. Caso contrário, A é decrementado por -1.

% B
% O cut presente no corpo da regra é verde, pois a sua presença em nada altera as soluções obtidas pelo predicado, apenas serve para evitar backtracking desnecessário.


% 8
% treinador_bom(?Treinador)
treinador_bom(Treinador):-
    treinadores(Equipa,Lista),
    member([J1-J2]-Treinador,Lista),
    treinador_bom_aux(J1,J2,Equipa).

treinador_bom_aux(J2,J2,_).
treinador_bom_aux(J1,J2,Equipa):-
    ganhou(J1,Equipa,_),
    NewJ is J1 + 1,
    treinador_bom_aux(NewJ,J2,Equipa).

    
% 9
imprime_totobola(1, '1'). 
imprime_totobola(0, 'X'). 
imprime_totobola(-1, '2'). 
imprime_texto(X,'vitoria da casa'):- X = 1. 
imprime_texto(X,'empate'):- X = 0. 
imprime_texto(X,'derrota da casa'):- X = -1.


% imprime_jogos(+F)
imprime_jogos(F):-
    jogo(Jornada,Equipa1,Equipa2,S1-S2),
    X is sign(S1 - S2),
    call(F, X, Y),
    format('Jornada ~d: ~a x ~a - ~a', [Jornada, Equipa1, Equipa2, Y]), nl,
    fail.
imprime_jogos(_).

% 10 R: E
% 11 R: E

% 12
% lista_treinadores(?L)
lista_treinadores(L):-
    findall(Coach,(treinadores(_,List), member(_-Coach,List)),L).


% 13
% duracao_treinadores(?L)
duracao_treinadores(L):-
    findall(N-Coach,(treinadores(_,List),member(_-Coach,List),n_jornadas_treinador(Coach,N)),L1),
    keysort(L1,L2),
    reverse(L2,L).

% 14
% pascal(+N, -L)
pascal(N,L):-
    pascal_aux(N,0,L).
    
pascal_aux(N,K,L):-
    K > N,
    L = [].
pascal_aux(N,K,[H|T]):-
    write(K),
    pascal_elem(N,K,H),
    NewK is K + 1,
    pascal_aux(N,NewK,T).



pascal_elem(_,0,1).
pascal_elem(N,N,1).
pascal_elem(N,K,Elem):-
    N > K,
    NewN is N - 1,
    NewK is K - 1,
    pascal_elem(NewN,NewK,Elem1),
    pascal_elem(NewN,K,Elem2),
    Elem is Elem1 + Elem2.