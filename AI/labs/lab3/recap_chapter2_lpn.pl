loves(vincent, mia).
loves(marecellus, mia).

jealous(A, B) :-
  loves(A, C),
  loves(B, C).
  % A @> B.
