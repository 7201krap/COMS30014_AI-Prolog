% CUTS
% first example
p(X) :- a(X).

p(X) :- b(X),c(X), !, d(X),e(X).

p(X) :- f(X).

a(1).

b(1).
b(2).

c(1).
c(2).

d(2).

e(2).

f(3).

% second example
s(0,0).
s(X,Y) :-
  q(X,Y).

q(X,Y) :-
  i(X), !, j(Y).

i(1).
i(2).

j(1).
j(2).
j(3).

% third example
max(X,Y,Y) :-
  X =< Y,
  !.  % program terminates here
max(X,Y,X) :-
  X > Y.

% IF THEN ELSE
% if A then B else C is written as ( A -> B ; C).

% first example
max_(X, Y, Z) :-
  (
  X =< Y -> Z = Y;  % if
  Z = X             % else
  ).

% Negation as failure
% example from youtube tutorials point
% 'Mary likes all animals but snakes'
% How can we write this above sentence in prolog?

% 'Mary likes any X if X is an animal'
likes(mary, X) :-
  animal(X).

% 'Mary likes all animals but snakes'
animal(dog).
animal(cat).
animal(elephant).
animal(tiger).
animal(cobra).
animal(python).

snake(cobra).
snake(python).

likes_(mary, X) :-
  snake(X), !, fail.
likes_(mary, X) :-
  animal(X).

% first example
enjoys(vincent, X) :- big_kahuna_burger(X), !, fail. % this cut(!) blocks access to the second rule.
enjoys(vincent, X) :- burger(X).

% !!! IMPORTANT !!!
neg(Goal) :-
  Goal,!,fail.  % 만약에 Goal 이 참이라면 여기로 들어와서 fail 하게 되고
neg(Goal).      % 만약에 Goal 이 참이 아니라면 자동으로 이쪽으로 넘어와서 그냥 단순 명제가 되니까 참을 반환한다.

% 이것을 한문장으로 말하면
% --> For any Prolog goal, neg(Goal) will succeed precisely if Goal does not succeed.

% second example
enjoys_(vincent, X) :-
  burger(X),
  \+ big_kahuna_burger(X).

% third example
enjoys__(vincent, X) :-
  burger(X),
  neg(big_kahuna_burger(X)).

% rules and database
burger(X) :-
  big_mac(X).
burger(X) :-
  big_kahuna_burger(X).
burger(X) :-
  whopper(X).

big_mac(a).
big_mac(c).
big_kahuna_burger(b).
whopper(d).
