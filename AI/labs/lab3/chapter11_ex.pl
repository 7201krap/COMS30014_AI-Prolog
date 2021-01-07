% EXERCISE
% ex 1
% ex 2
q(blob,blug).
q(blob,blag).
q(blob,blig).

q(blaf,blag).

q(dang,dong).
q(dang,blug).

q(flab,blob).

% setof 는 bagof 랑 비슷하게 작동하는데
% 가장 큰 차이점은 setof 는 원소가 중복되어서 출력 되지 않는다.

% usage: setof(X, Y^q(X, Y), List).
% -> 나는 X 에 대해서만 신경 쓸거다. List: ascending/alphabetical order
% 리스트를 한번에 출력한다
% usage: bagof(X, Y^q(X, Y), List).
% -> 나는 X 에 대해서만 신경 쓸거다. List: ascending/alphabetical order
% 리스트를 한번에 출력한다

% ex 3
% 이 바로 밑에 라인을 해줘야함
:- dynamic sigma_lookup/2.

sigma(1, 1) :- !.
sigma(X, Y) :-
  sigma_lookup(X, Y), !.
sigma(X, Y) :-
  Xnew is X - 1,
  sigma(Xnew, Ynew),
  Y is Ynew + Xnew + 1,
  assert(sigma_lookup(X, Y)).

% PRACTICAL
subset([], []).
% 앞에 head 가 같다면
subset([H|T], [H|S]) :-
  subset(T, S).
% 앞에 head 가 같지 않다면
subset(T, [_|S]) :-
  subset(T, S).

powerset(S, P) :-
  findall(X, subset(X, S), P).
