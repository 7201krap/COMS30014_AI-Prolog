% Lists : finite sequence of elements
% Only non empty list can be thought of as consisting of two parts: Head | Tail
% 예를 들어서 [dead(z)] 이면, [ dead(z) ] == [ dead(z) | [] ]
% head: dead(z)
% tail: []

% If we try to use | to pull [] apart, Prolog will fail
% [X|Y] = [] --> fail

% is_member
is_member(X, [X|_]).
is_member(X, [_|T]) :-
  is_member(X, T).

% Let’s suppose we need a predicate a2b/2 that takes two lists as arguments,
% and succeeds if the first argument is a list of a s,
% and the second argument is a list of b s of exactly the same length.
a2b([], []).
a2b([a|T1], [b|T2]) :-
  a2b(T1, T2).
