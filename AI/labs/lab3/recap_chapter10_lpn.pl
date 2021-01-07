% ex1
p(1).
p(2) :-
  !.
p(3).

% ex2
class(Number, positive) :-
  Number > 0,
  !.
class(0, zero) :- !.
class(Number, negative) :-
  Number < 0.

% ex3
split([], [], []).
split([H|T1], [H|T2], N) :-
  H >= 0,
  !,
  split(T1, T2, N).
split([H|T1], P, [H|T2]) :-
  H < 0,
  !,
  split(T1, P, T2).

% ex4
% A -> B
directTrain(saarbruecken,dudweiler).
directTrain(forbach,saarbruecken).
directTrain(freyming,forbach).
directTrain(stAvold,freyming).
directTrain(fahlquemont,stAvold).
directTrain(metz,fahlquemont).
directTrain(nancy,metz).

directPath(X, Y) :-
    directTrain(X, Y).

directPath(X, Y) :-
    directTrain(Y, X).

%% base case
route(Y, Y, RevL, L) :-
    reverse(RevL, L).

%% inductive case
route(X, Y, RevL, L) :-
    directPath(X, Z),
    not(member(Z, RevL)),
    route(Z, Y, [Z | RevL], L).

%% main
route(X, Y, L) :-
    route(X, Y, [X], L).
