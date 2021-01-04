combine1([], [], []).
combine1([H1 | T1], [H2 | T2], [H1, H2 | R]) :-
  combine1(T1, T2, R).

combine2([], [], []).
combine2([H1 | T1], [H2 | T2], [[H1, H2] | R]) :-
  combine2(T1, T2, R).

combine3([], [], []).
combine3([H1 | T1], [H2 | T2], [j(H1, H2) | R]) :-
  combine3(T1, T2, R).
