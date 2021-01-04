different(red, green).
different(red, blue).
different(green, red).
different(green, blue).
different(blue, red).
different(blue, green).

coloring(X, Y, Z, P, Q) :-
  different(Y, P),
  different(Y, X),
  different(X, P),
  different(X, Z),
  different(X, Q),
  different(Z, Q),
  different(Z, P).
