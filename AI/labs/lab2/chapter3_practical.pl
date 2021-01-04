% ex 1

connected(1,2).
connected(3,4).
connected(4,1).
connected(4,7).
connected(5,6).
connected(6,3).
connected(6,11).
connected(7,8).
connected(9,10).
connected(11,15).
connected(12,13).
connected(13,14).
connected(14,9).
connected(14,17).
connected(15,16).
connected(16,12).
connected(16,19).
connected(17,18).
connected(19,20).

path(X, Y) :-
  connected(X, Y).
path(X, Y) :-
  connected(X, Z),
  path(Z, Y).

% ex 2

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

travel(X, Y) :-
  byCar(X, Y); byTrain(X, Y); byPlane(X, Y).
travel(X, Y) :-
  (byCar(X, Z); byTrain(X, Z); byPlane(X, Z)),
  travel(Z, Y).

% ex 3

travel(X, Y, go(X, Y)) :-
  byCar(X, Y); byTrain(X, Y); byPlane(X, Y).
travel(X, Y, go(X, Y, G)) :-
  (byCar(X, Z); byTrain(X, Z); byPlane(X, Z)),
  travel(Z, Y, G).

% 제일 마지막 문제는 모르겠다. 
