% Basic facts
male(john).
male(mike).
male(paul).
male(david).
male(jake).

female(mary).
female(susan).
female(lisa).
female(emma).
female(sophia).

parent(john, mike).
parent(mary, mike).
parent(john, susan).
parent(mary, susan).

parent(mike, david).
parent(lisa, david).
parent(mike, emma).
parent(lisa, emma).

parent(susan, jake).
parent(paul, jake).

% Derived relationships

% X is grandparent of Y if X is parent of Z and Z is parent of Y
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).

% X is sibling of Y if they share a parent and are not the same person
sibling(X, Y) :-
    parent(P, X),
    parent(P, Y),
    X \= Y.

% X is cousin of Y if their parents are siblings
cousin(X, Y) :-
    parent(P1, X),
    parent(P2, Y),
    sibling(P1, P2),
    X \= Y.

% X is child of Y if Y is parent of X
child(X, Y) :- parent(Y, X).

% Recursively find descendants
descendant(X, Y) :- parent(Y, X).
descendant(X, Y) :- parent(Y, Z), descendant(X, Z).