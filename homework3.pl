%Facts
m([roger, brandon, corey, amadeusz, dennis, bob, george, dziadzia, danny, zachary, chris, charles]).
f([kristina, kayla, miranda, cecelia, babcia, barbara, mary, susan, theresa, megan, charlie]).
family([roger, kristina, [brandon,corey,kayla]]).
family([dziadzia, babcia, [cecelia, theresa]]).
family([george, barbara, [roger, dennis, bob, susan]]).
family([danny, mary, [miranda]]).
family([_,cecelia, [kristina, charles]]).
family([charles, _,[megan, zachary, chris, charlie]]).
family([corey, miranda, [amadeusz]]).

%Rules
male(X) :- m(M), member(X, M).

female(X) :- f(F), member(X, F).

father(F, Y) :- family([F,_| Children]), member(Y, Children), male(F).
mother(M, X) :- family([_, M | Children]), member(X, Children), female(M).
parent(P, Y) :- family([_, P, Children]), member(Y, Children).
parent(X, P) :- family([X,_, Children]), member(P, Children).

siblings1(S, Y) :- family([_,_, Children]), member(S, Children), member(Y, Children), S \= Y.
siblings2(S, Y) :- parent(P1, S), parent(P2, Y), P1 == P2, S \= Y.

brother1(B, Y) :- siblings1(B, Y) ,male(B), male(Y).
brother2(B, Y) :- siblings2(B, Y), male(B), male(Y).

sister1(S, Y) :- siblings1(S, Y), female(S), female(Y).
sister2(S, Y) :- siblings2(S, Y), female(S),female(Y).

cousins(X, Y) :- siblings1(S, B), parent(P1, X), parent(P2, Y), S == P1, B == P2.

uncle(U, Y) :- parent(P1, Y), siblings1(S, U), male(U), P1 == S.
aunt(A, Y) :- parent(P1, Y), siblings1(S, A), female(A), P1 == S.

grandparent(GP, Y) :- parent(X, Y), parent(GP, P), X == P.
grandchild(GC, GP) :- grandparent(GP, GC).
grandson(GC, GP) :- grandparent(GP, GC), male(GC), GP \= GC.
granddaughter(GC, GP) :- grandparent(GP, GC), female(GC), GP \= GC.

greatgrandparent(GGP, GC) :- parent(GGP, Y), grandparent(GP, GC), Y == GP, GGP \= GC.

ancestor(A, C) :- greatgrandparent(A, C).
ancestor(A, C) :- parent(P1, C), greatgrandparent(A, P1), C == P1, P1 \= A.
