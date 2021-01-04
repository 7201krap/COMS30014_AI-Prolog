likes(john, X) :-
  likes(X, wine).

may_steal(bob, Y) :-
  thief(bob),
  likes(bob, Y).

likes(mary, wine).
likes(bob, beer).
likes(wini, apple).
likes(charlie, wine).
likes(john, kiwi).

thief(bob).
