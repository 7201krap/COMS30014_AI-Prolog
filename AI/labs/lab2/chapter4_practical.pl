% ex1

combine1([], [], []).
combine1([X|XT], [Y|YT], [X,Y|Z]) :-
  combine1(XT, YT, Z).

combine2([], [], []).
combine2([X|XT], [Y|YT], [[X,Y]|Z]) :-
  combine2(XT, YT, Z).

combine3([], [], []).
combine3([X|XT], [Y|YT], [j(X, Y)|Z]) :-
  combine3(XT, YT, Z).
