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

%% ex 3-2-1

directlyIn(X, Y) :-
  bigger_doll(X, Y).

bigger_doll(katarina, olga).
bigger_doll(katarina, natasha).
bigger_doll(katarina, irina).
bigger_doll(olga, natasha).
bigger_doll(olga, irina).
bigger_doll(natasha, irina).

%% ex 3-2-2

in(X, Y) :-
  bigger_doll_in(X, Y).
in(X, Y) :-
  bigger_doll_in(X, Z),
  in(Z, Y).

bigger_doll_in(katarina, olga).
bigger_doll_in(olga, natasha).
bigger_doll_in(natasha, irina).

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

% greater_than(succ(succ(succ(0))),succ(0)). --> yes
% greater_than(succ(succ(0)),succ(succ(succ(0)))). --> no

%% ex 3-5
%% 이거는 잘 모르겠다.
swap(leaf(X), leaf(X)).
swap(tree(X, Y), tree(SwappedY, SwappedX)) :-
  swap(X, SwappedX),
  swap(Y, SwappedY).
