sneeze(me).
sneeze(jayden).
cough(me).
cough(jayden).
inteseHeat(me).
runnyNose(me).
runnyNose(jayden).
nosalCongestion(kim).
muscularAche(kim).

cold(X) :-
  sneeze(X),
  cough(X),
  runnyNose(X).

cold(X) :-
  sneeze(X),
  cough(X),
  nosalCongestion(X).

flu(X) :-
  inteseHeat(X),
  muscularAche(X).
