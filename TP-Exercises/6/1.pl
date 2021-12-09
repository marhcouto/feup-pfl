% A
female(grace).
female(haley).
female(dede).
female(gloria).
female(merle).
female(claire).
female(pameron).
female(lily).
female(poppy).
female(cameron).
male(manny).
male(frank).
male(phil).
male(jay).
male(javier).
male(barb).
male(george).
male(dylan).
male(mitchell).
male(joe).
male(bo).
male(calhoun).
male(rexford).
male(luke).
male(alex).
parent(grace,phil).
parent(frank,phil).
parent(dede,claire).
parent(dede,mitchell).
parent(jay,claire).
parent(jay,mitchell).
parent(jay,joe).
parent(gloria,joe).
parent(gloria,manny).
parent(javier,manny).
parent(barb,cameron).
parent(barb,pameron).
parent(merle,cameron).
parent(merle,pameron).
parent(phil,haley).
parent(phil,alex).
parent(phil,luke).
parent(claire,haley).
parent(claire,alex).
parent(claire,luke).
parent(mitchell,lily).
parent(mitchell,rexford).
parent(cameron,lily).
parent(cameron,rexford).
parent(pameron,calhoun).
parent(bo,calhoun).
parent(dylan,poppy).
parent(dylan,george).
parent(haley,poppy).
parent(haley,george).

% B
/*
| ?- female(haley).
yes
| ?- male(gil).
no
| ?- parent(frank,phil).
yes
| ?- parent(X,claire).
X = dede ? ; 
X = jay ? ;
no
| ?- parent(gloria,X).
X = joe ? ;
X = manny ? ;
no
| ?- parent(jay,Child), parent(Child,Grandchild)^[[1;5D^[[1;5 
     abort
     ^C
Prolog interruption (h for help)? abort
% Execution aborted
| ?- parent(jay,_Child), parent(_Child,Grandchild).
Grandchild = haley ? ;
Grandchild = alex ? ;
Grandchild = luke ? ;
Grandchild = lily ? ;
Grandchild = rexford ? ;
no
| ?- parent(_Parent,lily), parent(Grandparent,lily).
Grandparent = mitchell ? ;
Grandparent = cameron ? ;
Grandparent = mitchell ? ;
Grandparent = cameron ? ;
no
| ?- parent(Grandparent,_Parent), parent(_Parent,lily).
Grandparent = dede ? ;
Grandparent = jay ? ;
Grandparent = barb ? ;
Grandparent = merle ? ;
no
| ?- parent(_Parent,lily), parent(Grandparent, _Parent).
Grandparent = dede ? ;
Grandparent = jay ? ;
Grandparent = barb ? ;
Grandparent = merle ? ;
no
| ?- parent(alex,_).
no
| ?- parent(jay,X), \+ parent(gloria,X).
X = claire ? ;
X = mitchell ? ;
no
*/

% C

father(X,Y):- parent(X,Y), male(X).
grandparent(X,Y):- parent(Z,Y), parent(X,Z).
gradmother(X,Y):- grandparent(X,Y), female(X).
siblings(X,Y):- parent(P1,X), parent(P1,Y), parent(P2,Y), parent(P2,X), X \= Y, P1 @< P2.
halfsiblings(X,Y):- parent(P1,X), parent(P1,Y), \+ siblings(X,Y), X \= Y.
cousins(X,Y):- parent(P1,X), parent(P2,Y), siblings(P1,P2), \+ siblings(X,Y).
first_alphabetical_child(P,C):- parent(P,C), \+ (parent(P,D), D @< C).

% D
/*
| ?- siblings(X,Y).
X = claire,
Y = mitchell ? ;
X = mitchell,
Y = claire ? ;
X = cameron,
Y = pameron ? ;
X = pameron,
Y = cameron ? ;
X = haley,
Y = alex ? ;
X = haley,
Y = luke ? ;
X = alex,
Y = haley ? ;
X = alex,
Y = luke ? ;
X = luke,
Y = haley ? ;
X = luke,
Y = alex ? ;
X = lily,
Y = rexford ? ;
X = rexford,
Y = lily ? ;
X = poppy,
Y = george ? ;
X = george,
Y = poppy ? ;
no
*/

% E
married(jay,gloria,2003).
married(jay,dede,1968).
divorced(jay,dede,2003).

currently_married(A,B,Year):- married(A,B,Y), Y =< Year, \+ divorced(A,B,_).

currently_married(A,B,Year):- married(A,B,Y), Y =< Year, \+ divorced(A,B,Y2), Y2 >= Year.

