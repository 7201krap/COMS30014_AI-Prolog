%% http://www.learnprolognow.org/lpnpage.php?pagetype=html&pageid=lpn-htmlch3

%% example 1

is_digesting(X, Y) :-
  just_ate(X, Y).
is_digesting(X, Y) :-
  just_ate(X, Z),
  is_digesting(Z, Y).

just_ate(mosquito,blood(john)).
just_ate(frog,mosquito).
just_ate(stork,frog).

%% example 2

descend(X, Y) :-
  child(X, Y).
descend(X, Y) :-
  child(X, Z),
  descend(Z, Y).

child(anne,bridget).
child(bridget, caroline).
child(caroline, donna).
child(donna,emily).

%% example 3

numeral(0).

numeral(succ(X)) :-
  numeral(X).

%% example 4

add(0,Y,Y). % base case
add(succ(X), Y, succ(Z)) :-
  add(X, Y, Z).
