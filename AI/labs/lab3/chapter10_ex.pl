% 10-1
% first example
p(X):-
  a(X).

p(X):-
  b(X), % lhs
  c(X), % lhs
  !,    % Backtracking to the left of the cut is not allowed, so it can’t reset X to 2
  d(X), % rhs
  e(X). % rhs

p(X):-
  f(X).

a(1).
b(1).
b(2).
c(1).
c(2).
d(2).
e(2).
f(3).

% second example
% *** cut blocks backtracking ***
s(X,Y):-
  q(X,Y).

s(0,0).

q(X,Y):-
  i(X), % lhs
  !,    % Backtracking to the left of the cut is not allowed, so it can’t reset X to 2
  j(Y). % rhs

i(1).
i(2).
j(1).
j(2).
j(3).

% 10-2
% We need to insist that Prolog should never try both clauses, and the following code does this:
max(X,Y,Y)  :-
  X  =<  Y,
  !. % the two clauses in the above program are mutually exclusive
max(X,Y,X)  :-
  X > Y.

% 10-3
%
% When we pose the query enjoys(vincent,b) , the first rule applies, and we reach the cut.
% This commits us to the choices we have made, and in particular, ** blocks access to the second rule. **
% But then we hit fail/0 .
% This tries to force backtracking, but the cut blocks it, and so our query fails.
%
% he likes all burgers except Big Kahuna burgers
% then he should enjoy burgers a , c and d , but not b
enjoys(vincent,X)  :-
  % when Prolog fails, it tries to backtrack
  % cut-fail combination
  big_kahuna_burger(X),!,fail.
enjoys(vincent,X)  :-
  burger(X).

burger(X)  :-
  big_mac(X).
burger(X)  :-
  big_kahuna_burger(X).
burger(X)  :-
  whopper(X).

big_mac(a).
big_mac(c).
big_kahuna_burger(b).
whopper(d).

% 10-4

enjoys_(vincent,X)  :-
  burger_(X),
  % big_kahuna_burger_(X) 를 제외한 나머지를 enjoy 하고 싶다면 이렇게 해주면 된다.
  \+ big_kahuna_burger_(X).
  % true ^ false == false

burger_(X)  :-
  big_mac_(X).
burger_(X)  :-
  big_kahuna_burger_(X).
burger_(X)  :-
  whopper_(X).

big_mac_(a).
big_mac_(b).
big_mac_(c).
big_kahuna_burger_(b).
whopper_(b).
whopper_(d).
