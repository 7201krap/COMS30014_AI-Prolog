% example 1
f(X, 0) :-
  X < 3,
  !.
f(X, 2) :-
  X >= 3, X < 6,
  !.
f(X, 4) :-
  X >=6.

% A sample query for example 1
% ?- f(1, Y), Y > 2.

% example 2
max(X, Y, X) :-
  X >= Y, !.
max(X, Y, Y) :-
  X < Y.

% example 3
list_member(X, [X|_]) :- !.
list_member(X, [_|L]) :-
  list_member(X, L).
