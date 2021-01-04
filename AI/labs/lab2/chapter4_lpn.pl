% 4.2
member(X,[X|_]).
member(X,[_|T])  :-
  member(X,T).

% 4.3
a2b([], []).
a2b([a|Ta], [b|Tb]) :-
  a2b(Ta, Tb).
