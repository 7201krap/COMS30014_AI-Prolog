% 14, 16, 17

% calculate maximum and minimum of two given numbers
max(X, Y, Max) :-
  % if
  X >= Y -> Max is X;
  % else
  Max is Y.

min(X, Y, Min) :-
  % if
  Y >= X -> Min is X;
  % else
  Min is Y.

% horizontal and vertical line segments
v_h_o(p(X1, Y1), p(X2, Y2)) :-
  (X1 == X2, Y1 == Y2)   -> write('same point');
  (X1 == X2,  Y1 \== Y2) -> write('vertical');
  (X1 \= X2,  Y1 == Y2)  -> write('horizontal');
  (X1 \== X2, Y1 \== Y2) -> write('oblique').

% monkey and banana problem
% state(
%       horizontal monkey location,
%       vertical monkey location,
%       horizontal box location,
%       did monkey get a banana?
%       ),
% operation name
% state(
%       horizontal monkey location,
%       vertical monkey location,
%       horizontal box location,
%       did monkey get a banana?
%       ),

% money grasps a banana
move(state(middle, onbox, middle, hasnot),
     grasp,
     state(middle, onbox, middle, has)).

% monkey climbs on the box
move(state(P, onfloor, P, hasnot),
     climb,
     state(P, onbox,   P, hasnot)).

% monkey pushes the box
move(state(P1, onfloor, P1, hasnot),
     push(P1, P2),
     state(P2, onfloor, P2, hasnot)).

% monkey walks to somewhere
move(state(P1, onfloor, B, hasnot),
     walk(P1, P2),
     state(P2, onfloor, B, hasnot)).

get_banana(state(_,_,_,has)).
get_banana(S1) :-
  move(S1, _, S2),
  get_banana(S2).
