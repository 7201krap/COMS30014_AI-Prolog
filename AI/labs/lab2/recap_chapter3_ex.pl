%% ex 3-1

descend(X,Y)  :-
  child(X,Y).
descend(X,Y)  :-
  descend(X,Z),
  descend(Z,Y).

child(anne,bridget).
child(bridget, caroline).
child(caroline, donna).
child(donna,emily).

%% ex 3-2

directlyIn(katarina, olga).
directlyIn(olga, natasha).
directlyIn(natasha, irina).

in(X, Y) :-
  directlyIn(X, Y).
in(X, Y) :-
  directlyIn(X, Z),
  in(Z, Y).

%% ex 3-3

directTrain(saarbruecken,dudweiler).
directTrain(forbach,saarbruecken).
directTrain(freyming,forbach).
directTrain(stAvold,freyming).
directTrain(fahlquemont,stAvold).
directTrain(metz,fahlquemont).
directTrain(nancy,metz).

travelFromTo(X, Y) :-
  directTrain(X, Y).
travelFromTo(X, Y) :-
  directTrain(X, Z),
  travelFromTo(Z, Y).

%% ex 3-4

greater_than(succ(_), 0).
greater_than(succ(X), succ(Y)) :-
  greater_than(X, Y).

%% ex 3-5 --> OK 
swap(leaf(X), leaf(X)).
swap(tree(X, Y), tree(SwappedY, SwappedX)) :-
  swap(X, SwappedX),
  swap(Y, SwappedY).
