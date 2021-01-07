% EXERCISE

% 1+2 is 1+2.    --> false
% 3+2 = +(3,2).  --> true
% *(7,5) = 7*5.  --> true
% 3 is X+2.      --> false

% 5.2.1
increment(X, Y) :-
  Y is X + 1.

% 5.2.2
sum(X, Y, Z) :-
  Z is X + Y.

% 5.3
addone([], []).
addone([H1|T1], [H2|T2]) :-
  H2 is H1 + 1,
  addone(T1, T2).

% PRACTICAL SESSION
% 1. min of list
min_of_list([H|T], A, Max) :-
  H < A,
  min_of_list(T, H, Max).

min_of_list([H|T], A, Max) :-
  H >= A,
  min_of_list(T, A, Max).

min_of_list([], A, A).

min(List, Min) :-
  List = [H|_],
  min_of_list(List, H, Min).

% 2. scalarMult :
% a 3-place predicate scalarMult whose first argument
% is an integer, whose second argument is a list of
% integers, and whose third argument is the result of
% scalar multiplying the second argument by the first

scalarMult(_, [], []).
scalarMult(M, [H1|T1], [H2|T2]) :-
  H2 is H1 * M,
  scalarMult(M, T1, T2).

% 3. dot product
% a 3-place predicate dot whose first argument is a list of
% integers, whose second argument is a list of integers of the
% same length as the first, and whose third argument is the dot
% product of the first argument with the second.

mul([], [], A, A).
mul([H1|T1], [H2|T2], R, Ans) :-
  Rnew is R + H1 * H2,
  mul(T1, T2, Rnew, Ans).

dot(List1, List2, A) :-
  mul(List1, List2, 0, A).

%
dot2([], [], 0).
dot2([H1|T1], [H2|T2], R) :-
  dot2(T1, T2, R1),
  R is R1 + H1 * H2.
