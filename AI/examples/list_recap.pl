% ---------------------------------------------------------------
%% 예제 1 - print all elements in the list
printele([]) :-
  write('').
printele([H|T]) :-
  write('-> '),
  write(H),
  write('\n'),
  printele(T).

% ---------------------------------------------------------------
%% 예제 2 - find a specific element in the list
% if the element is     in the list then true
% if the element is not in the list then false
is_element([H|_], X) :-
  H = X,
  !.
is_element([H|T], X) :-
  \+ (H=X),
  is_element(T, X).

% ---------------------------------------------------------------
%% 예제 5 - 짝수만 골라내는 프로그램

% base case
even_list([], Even_L, FinalList) :-
  reverse(Even_L, FinalList).

% when H is even
even_list([H|T], Even_L, FinalList) :-
  0 =:= H mod 2, !, % mutually exclusive (odd <-> even)
  even_list(T, [H|Even_L], FinalList).

% when H is not even; it is odd
even_list([_|T], Even_L, FinalList) :-
  even_list(T, Even_L, FinalList).

% execute this
% all_evens_1([1,2,3,4,5], X).
all_evens_1(L, FinalList) :-
  even_list(L, [], FinalList).

% ---------------------------------------------------------------
%% 예제 5-1 - 짝수만 골라내는 프로그램
number_of_even(X, [X|_]) :-
  0 =:= X mod 2.
number_of_even(X, [_|Y]) :-
  number_of_even(X,Y).

all_evens_2(List, Xs) :-
  findall(X, number_of_even(X, List), Xs).

% ---------------------------------------------------------------
%% 예제 6 - find maximum value of a list
findmax([H|T], X, Y) :-
  H < X, !, % mutually exclusive
  findmax(T, X, Y).

findmax([H|T], X, Y) :-
  H >= X,
  findmax(T, H, Y).

findmax([], Y, Y).

max_list([H|T], Y) :-
  findmax([H|T], H, Y).
