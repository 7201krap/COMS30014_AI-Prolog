length_([], 0).
length_([H|T], N) :-
  N is 1+M,
  length_(T, M).
