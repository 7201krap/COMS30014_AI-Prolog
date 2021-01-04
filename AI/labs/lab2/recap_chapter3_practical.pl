% 1
path(X, Y) :-
  connected(X, Y).
path(X, Y) :-
  connected(X, Z),
  path(Z, Y).

% 2
travel(X, Y) :-
  byCar(X, Y); byTrain(X, Y); byPlane(X, Y).
travel(X, Y) :-
  (byCar(X, Z); byTrain(X, Z); byPlane(X, Z)),
  travel(Z, Y).

% 3
travel(X,Y, go(X,Y)) :-
  byCar(X,Y).
travel(X,Y, go(X,Y)) :-
  byPlane(X,Y).
travel(X,Y, go(X,Y)) :-
  byTrain(X,Y).

%% Inductive cases
travel(X,Y, go(X,Z,G)) :-
  byCar(X,Z),
  travel(Z,Y,G).

travel(X,Y, go(X,Z,G)) :-
  byPlane(X,Z),
  travel(Z,Y,G).

travel(X,Y, go(X,Z,G)) :-
  byTrain(X,Z),
  travel(Z,Y,G).

% 4
travel_path(X,Y, go(byCar(X,Y))) :-
  byCar(X,Y).
travel_path(X,Y, go(byPlane(X,Y))) :-
  byPlane(X,Y).
travel_path(X,Y, go(byTrain(X,Y))) :-
  byTrain(X,Y).

%% Inductive cases
travel_path(X,Y, go(byCar(X,Z), G)) :-
  byCar(X,Z),
  travel_path(Z,Y,G).

travel_path(X,Y, go(byPlane(X,Z), G)) :-
  byPlane(X,Z),
  travel_path(Z,Y,G).

travel_path(X,Y, go(byTrain(X,Z), G)) :-
  byTrain(X,Z),
  travel_path(Z,Y,G).



% DATABASE

connected(1,2).
connected(3,4).
connected(5,6).
connected(7,8).
connected(9,10).
connected(12,13).
connected(13,14).
connected(15,16).
connected(17,18).
connected(19,20).
connected(4,1).
connected(6,3).
connected(4,7).
connected(6,11).
connected(14,9).
connected(11,15).
connected(16,12).
connected(14,17).
connected(16,19).

byCar(auckland,hamilton).
byCar(hamilton,raglan).
byCar(valmont,saarbruecken).
byCar(valmont,metz).

byTrain(metz,frankfurt).
byTrain(saarbruecken,frankfurt).
byTrain(metz,paris).
byTrain(saarbruecken,paris).

byPlane(frankfurt,bangkok).
byPlane(frankfurt,singapore).
byPlane(paris,losAngeles).
byPlane(bangkok,auckland).
byPlane(singapore,auckland).
byPlane(losAngeles,auckland).
