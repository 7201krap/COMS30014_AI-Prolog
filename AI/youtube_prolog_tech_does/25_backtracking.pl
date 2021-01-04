% backtracking example 1
boy(john).
boy(harry).
girl(mary).
girl(jenna).

possible_pair(X, Y) :-
  boy(X),
  girl(Y).


% backtracking example 2
is_integer(0).
is_integer(X) :-
  is_integer(Y),
  X is Y + 1.
