%% 예제 1
likes(john, X) :-
  likes(X, wine).

likes(marry, wine).

%% 예제 2
human(socrates).
mortal(X) :- human(X).

%% 예제 3
player(hong).
intelligent(hong).
succeed(X) :- healthy(X), intelligent(X).
healthy(X) :- player(X).

%% 예제 4
allowed_input(A):- A < 4, A > 0.
restricted_sum(A,B,C):-
   allowed_input(A),      % test user input's
   allowed_input(B),      % validity
   C is A+B.              % test the result

%% 예제 5
dog(john).
cat(mary).
monkey(james).
friendly(john, james).
friendly(X, Y) :- dog(X), cat(Y).

%% 예제 6
time_table(seoul, daejeon, 800, 930).
time_table(seoul, daejeon, 900, 1030).
time_table(daejeon, gangju, 940, 1240).
time_table(daejeon, gangju, 1040, 1340).

plan(S_Station, A_Station, S_time, A_time) :-
  time_table(S_Station, T_Station, S_time, T_A_time),
  time_table(T_Station, A_Station, T_S_time, A_time),
  >(T_S_time, T_A_time).

%% 예제 7 - backtracking
color(sky, blue).
color(leaf, green).
color(moon, yellow).
color(apple, red).
color(banana, yellow).
fruit(strawberry).
fruit(banana).
fruit(orange).

%% 예제 8 recursive
factorial(0, 1) :- !.
factorial(N, A) :-
  N > 0,
  N1 is N-1,
  factorial(N1, A1),
  A is N * A1.

%% 예제 9 power
power(_, 0, 1).
power(X, Y, Z) :-
  Y1 is Y-1,
  power(X, Y1, Z1),
  Z is Z1 * X.



% power(3,2,P) = 8
