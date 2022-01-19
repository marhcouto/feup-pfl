% A

fatorial(0,1).
fatorial(N,F):- N > 0, 
                N1 is N-1,
                fatorial(N1,F1), 
                F is N * F1.

% TAIL RECURSION
fatorial2(N,F):- fatorial(N,F,1).

fatorial(0,F,F).
fatorial(N,F,Acc):- N > 0, 
                    N1 is N-1,
                    Acc1 is Acc * N,
                    fatorial2(N1,F,Acc1).

% B

somaRec(0,0).
somaRec(N,Sum):- N > 0,
                N1 is N - 1,
                somaRec(N1,Sum1),
                Sum is Sum1 + N.


% C

fibonacci(0,0).
fibonacci(1,1).
fibonacci(N,F):- N > 1,
                N1 is N - 1,
                N2 is N - 2,
                fibonacci(N1,F1),
                fibonacci(N2,F2),
                F is F1 + F2.

% D

isPrime(1).
isPrime(X):- N is X - 1, \+ isPrimeAux(X,N).

isPrimeAux(X,N):- N > 1, X rem N =:= 0.
isPrimeAux(X,N):- N > 1, N1 is N - 1, isPrimeAux(X,N1).


% Extra

invert([],[]).
invert([H|T], Rev):-
    invert(T,TRev),
    append(TRev,[H],Rev).

invert2(L,Rev):-
    invert2_aux(L,[],Rev).

invert2_aux([],L,L).
invert2_aux([H|T],Acc,L):-
    invert2_aux(T,[H|Acc],L).