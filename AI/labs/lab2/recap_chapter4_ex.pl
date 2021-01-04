% 4.1
% [a,b,c,d]  =  [a,[b,c,d]].  --> false
% [a,b,c,d]  =  [a|[b,c,d]].  --> true
% [a,b,c,d]  =  [a,b,[c,d]].  --> false
% [a,b,c,d]  =  [a,b|[c,d]].  --> true
% [a,b,c,d]  =  [a,b,c,[d]].  --> false
% [a,b,c,d]  =  [a,b,c|[d]].  --> true
% [a,b,c,d]  =  [a,b,c,d,[]]. --> false
% [a,b,c,d]  =  [a,b,c,d|[]]. --> true
% [a,b,c,d]  =  [a,b,c,d| _]. --> true

% []  =  _.                   --> true    % 이거 매우 중요!!!
% []  =  [_].                 --> false
% []  =  [_|[]].              --> false

% 4.2
% [1|[2,3,4]]           --> syntactically correct, length(elements) = 4
% [1,2,3|[]]            --> syntactically correct, length(elements) = 3
% [1|2,3,4]             --> incorrect
% [1|[2|[3|[4]]]]       --> syntactically correct, length(elements) = 4
% [1,2,3,4|[]]          --> syntactically correct, length(elements) = 4
% [[]|[]]               --> syntactically correct, length(elements) = 1
% [[1,2]|4]             --> incorrect
% [[1,2],[3,4]|[5,6,7]] --> syntactically correct, length(elements) = 5

% Take away point:
% Tail 부분에 있는 [] 는 count 하지 않는다.
% Tail 부분에 있는 [5,6,7] 같은것은 5,6,7 로 해석 하여야 한다.

% list 의 길이 구하기
list_length([], 0).
list_length([_|T], L) :-
  list_length(T, L1),
  L is L1 + 1.

% Write a predicate second(X,List)
% which checks whether X is the second element of List.
second_ele(X, [_, X | _]).


% Write a predicate swap12(List1, List2)
% which checks whether List1 is identical to List2 ,
% except that the first two elements are exchanged.
swap12([H0, H1 | T], [H1, H0 | T]).

% listtran(G,E): translates a
% list of German number words to the corresponding
% list of English number words.

% DATABASE
tran(eins,one).
tran(zwei,two).
tran(drei,three).
tran(vier,four).
tran(fuenf,five).
tran(sechs,six).
tran(sieben,seven).
tran(acht,eight).
tran(neun,nine).

listtran([], []).
listtran([H1|T1], [H2|T2]) :-
  tran(H1, H2),
  listtran(T1, T2).

% twice(In,Out) whose left argument is a list,
% and whose right argument is a list consisting of every element
% in the left list written twice.
% For example, the query
% twice([a,4,buggle],X). should return
% X = [a,a,4,4,buggle,buggle]).

twice([], []).
twice([H|T1], [H, H|T2]) :-
  twice(T1, T2). 
