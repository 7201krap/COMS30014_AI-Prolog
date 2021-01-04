% append
append_([], A, A).
append_([H|T1], L, [H|T3]) :-
  append_(T1, L, T3).

prefix(P, L) :-
  append_(P, _, L).

suffix(S, L) :-
  append_(_, S, L).

sublist(A, L) :-
  prefix(A, B),
  suffix(B, L).

% reverse
reverse([], []).
reverse([H|T], R) :-
  reverse(T, Rnew),
  append_(Rnew, [H], R).


% reverse with accumulator
reverse2([], A, A).
reverse2([H|T], A, R) :-
  reverse2(T, [H|A], R).

reverse_(L, R) :-
  reverse2(L, [], R).
