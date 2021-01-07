% simple example
add_3_and_double(X, Y) :-
  Y is (X+3) * 2.

% add_3_and_double(X, 12).
% 이거는 실행 되지 않음. 왜냐하면 X 가 instantiate 되지 않아서

% add_3_and_double(12, X).
% 이거는 실행 됨. 왜냐하면 X 가 instantiate 되어 있어서

% length of list
len([], 0).
len([_|T], X) :-
  len(T, X1),
  X is X1 + 1.

% length of list using accumulator
accLen([], A, A).
accLen([_|T], A, L) :-
  Anew is A + 1,
  accLen(T, Anew, L).

leng(List, Length) :- accLen(List, 0, Length).


% find maximum value in a list
max_of_list([H|T], A, Max) :-
  H > A,
  max_of_list(T, H, Max).

max_of_list([H|T], A, Max) :-
  H =< A,
  max_of_list(T, A, Max).

max_of_list([], A, A).

max(List, Max) :-
  List = [H|_],
  max_of_list(List, H, Max).
