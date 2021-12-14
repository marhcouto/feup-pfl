cargo(tecnico, eleuterio).
cargo(tecnico, juvenaldo).
cargo(analista, leonilde).
cargo(analista, marciliano).
cargo(engenheiro, osvaldo).
cargo(engenheiro, porfirio).
cargo(engenheiro, reginaldo).
cargo(supervisor, sisnando).
cargo(supervisor_chefe, gertrudes).
cargo(secretaria_exec, felismina).
cargo(diretor, asdrubal).
chefiado_por(tecnico, engenheiro).
chefiado_por(engenheiro, supervisor).
chefiado_por(analista, supervisor).
chefiado_por(supervisor, supervisor_chefe).
chefiado_por(supervisor_chefe, diretor).
chefiado_por(secretaria_exec, diretor).

% A

% cargo do individuo cujo nome é sisnando e chefia analista
% quem chefia os que chefiam os tecnicos
% quem é chefiado por supervisor e o seu cargo
% quem é chefiado pelo diretor e o seu cargo mas que não tenha o mesmo cargo que a felismina


% B

/*
X = supervisor

X = engenheiro
Y = supervisor

J = analista
P = leonilde

P = supervisor_chefe
*/


% C

chefe(X,Y):- chefiado_por(Y,X).
chefe_comum(X,Y):- chefiado_por(X,P), chefiado_por(Y,P), X \= Y.
cargo_menor(X):- \+ chefiado_por(_,X).
nao_chefiado(X):- cargo(_C,X), \+ chefiado_por(_C, _). 