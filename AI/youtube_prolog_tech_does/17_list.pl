% 그 원소가 list 안에 있는지 없는지 체크
is_exist(X, [X|_]).
is_exist(X, [_|T]) :-
  is_exist(X, T).

% list 의 길이 구하기
list_length([], 0).
list_length([_|T], L) :-
  list_length(T, L1),
  L is L1 + 1.

% 왜 list_length(T, L1) 와 L is L1 + 1. 의 순서가 바뀌면 안되나?
% 우측에 있는 것을 알고 있어야 좌측 값 (L) 을 구할 수 있음 !!
% list_length([], 0) 이 조건 때문에 마지막 값 L1==0 을
% 마지막 iteration 에 알 수 있음. 만약에 순서가 바뀐다면,
% variable_1 is variable_2 + 1 형태가 되어서 말이 연산이 불가능함.

% list 원소의 합 구하기
sum_list([], 0).
sum_list([H|T], S) :-
  sum_list(T, S1),
  S is S1 + H.

% list 가 sorted 되었는지 체크
is_sorted([ ]).
is_sorted([_]).
is_sorted([H1, H2 | T]) :-
  H1 =< H2,
  is_sorted([H2|T]).

% append and concat
app_and_concat(X, [], X).
app_and_concat([], Y, Y).
app_and_concat([H|T1], Y, [H|T2]) :-
  app_and_concat(T1, Y, T2).
app_and_concat(X, [H|T1], [H|T2]) :-
  app_and_concat(X, T1, T2).

% accumulator
accLen([], A, A).
accLen([_|T], A, L) :-  % [4] == [4|_]
  A_new is A + 1,
  accLen(T, A_new, L).

len(List, Length) :-
  accLen(List, 0, Length).
