%% 예제 1 - print all elements in the list
number_of(_,[]) :-
  !.
number_of(_,[Head|Tail]) :-
  writeln(Head),
  number_of(_, Tail).

%% 예제 2 - find a specific element in the list
number_of_find_ele(X, [X|_]).
number_of_find_ele(X, [_|Y]) :-
  number_of_find_ele(X,Y).

%% 예제 3 - find a specific element in the list
number_of_find_ele_2(X,[X|_]) :-
  !.
number_of_find_ele_2(X,[_|Y]) :-
  number_of_find_ele_2(X,Y).

%% 예제 4 - print the first element of the list
head([Head|_], Head) :-
  writeln(Head).

%% 예제 5 - 짝수만 골라내는 프로그램
number_of_even(X, [X|_]) :-
  0 =:= X mod 2.
number_of_even(X, [_|Y]) :-
  number_of_even(X,Y).

%% 예제 6 - 짝수만 골라내는 프로그램
number_of_odd(X, [X|_]) :-
  1 =:= X mod 2.
number_of_odd(X, [_|Y]) :-
  number_of_odd(X,Y).

%% 예제 7 - 세 개의 정수의 합과 평균
