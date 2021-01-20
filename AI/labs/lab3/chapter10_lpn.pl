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
  write('--- checkpoint1 ---\n'),
  reverse(RevL, L).

%% inductive case
%% L 은 항상 비어있고, 마지막에 base case 에서 reverse 를 해서 L 을 구해준다.
route(X, Y, RevL, L) :-
  write('--- checkpoint2 ---\n'),
  directPath(X, Z),

  % Z 는 RevL 의 멤버이면 안된다. 즉 이미 거쳤던 역이였으면 안됨.
  write('--- checkpoint3 ---\n'),
  \+ member(Z, RevL),

  % 거쳤던 역을 차례대로 RevL 에 넣어준다.
  write('--- checkpoint4 ---\n'),
  % Z 가 종착역과 같으면 도착한 것이다. base case 로 가서 프로그램 종료.
  route(Z, Y, [Z | RevL], L).

%% main
route(X, Y, L) :-
  write('--- checkpoint5 ---\n'),
  route(X, Y, [X], L).

directTrain(saarbruecken,dudweiler).
directTrain(forbach,saarbruecken).
directTrain(freyming,forbach).
directTrain(stAvold,freyming).
directTrain(fahlquemont,stAvold).
directTrain(metz,fahlquemont).
directTrain(nancy,metz).

% This can be another answer.
train_(X,Y) :- directTrain(Y,X) ; directTrain(X,Y).
route_(X,Y,[X,Y]) :- train_(X,Y), ! .
route_(X,Y,[X|R]) :- train_(X,Z), route_(Z,Y,R).

% --------------------------------------------------
% ex-5
jealous(X,Y):-
  loves(X,Z),
  loves(Y,Z),
  X @> Y.

loves(vincent, mia).
loves(marsellus, mia).
