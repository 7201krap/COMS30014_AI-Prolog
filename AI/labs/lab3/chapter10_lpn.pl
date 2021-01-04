% 10.4
% --------------------------------------------------
% ex-1
p(1).
p(2)  :-
  !. %  ** blocks access to the third rule. **
p(3).
% --------------------------------------------------
% ex-2
class(Number,positive)  :-
  Number  >  0,
  !.
class(0,zero) :-
  !.
class(Number,negative)  :-
  Number  <  0.
% --------------------------------------------------
% ex-3
split_([], [], []).

split_([H1 | T1], [H1 | Positive_tail], N) :-
  H1 >= 0,
  !,
  split_(T1, Positive_tail, N).

split_([H2 | T1], P, [H2 | Negative_tail]) :-
  H2 < 0,
  !,
  split_(T1, P, Negative_tail).

% --------------------------------------------------
% ex-4
directPath(X, Y) :-
  directTrain(X, Y).

directPath(X, Y) :-
  directTrain(Y, X),
  !.

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

% --------------------------------------------------
% ex-5
jealous(X,Y):-
  loves(X,Z),
  loves(Y,Z),
  X @> Y.

loves(vincent, mia).
loves(marsellus, mia).
