a(a1, 1).
a(A2, 2).
a(a3, N).
b(1, b1).
b(2, B2).
b(N, b3).
c(X, Y):- a(X, Z), b(Z, Y).
d(X, Y):- a(X, Z), b(Y, Z).
d(X, Y):- a(Z, X), b(Z, Y).


% B
/*
yes

A = 2

A = a1

A = a1
B = b1
A = a1
B = b3

A = a1,
B = 2 ? ;
B = 2 ? ;
A = a3,
B = 1 ? ;
A = a3,
B = 2 ? ;
A = a3 ? ;
A = 1,
B = b3 ? ;
A = 2,
B = b1 ? ;
A = 2 ? ;
A = 2,
B = b3 ? ;
B = b3 ? ;
*/