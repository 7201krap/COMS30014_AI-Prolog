% True if A is a possible movement direction
m(A) :-
  A == n;A == e;A == s;A == w.

% True if p(X,Y) is on the board
on_board(p(X,Y)) :-
  ailp_grid_size(S),
  (X > 0), (X < S),
  (Y > 0), (Y < S).

% True if p(X1,Y1) is one step in direction M from p(X,Y) (no bounds check)
pos_step(p(X,Y), M, p(X1,Y1)) :-
  M == e -> (X1 is X + 1, Y1 is Y); % e
  M == w -> (X1 is X - 1, Y1 is Y); % w
  M == m -> (X1 is X, Y1 is Y + 1); % n
  M == s -> (X1 is X, Y1 is Y - 1). % s


% True if NPos is one step in direction M from Pos (with bounds check)
new_pos(Pos,M,NPos) :-
  pos_step(Pos, M, NPos),
  on_board(NPos).

% True if a L has the same length as the number of squares on the board
complete(L) :-
  ailp_grid_size(S),
  X is S * S,
  L == X.

% SPIRAL 은 어떻게 하는지 잘 모르겠다.
% Perform a sequence of moves creating a spiral pattern, return the moves as L

turn(north,east,clockwise).
turn(east,south,clockwise).
turn(south,west,clockwise).
turn(west,north,clockwise).

turn(D1,D2,anticlockwise) :-
  turn(D2,D1,clockwise).

spiral(Ps,Qs,_) :-
  complete(Ps), !, reverse(Ps,Qs).

spiral([Q,P|Ps],Qs,S) :-
  new_pos(P,D,Q),
  (C=D ; turn(D,C,S)),
  new_pos(Q,C,R),
  \+ member(R,[P|Ps]),
  spiral([R,Q,P|Ps],Qs,S).

spiral(Ps) :-
  my_agent(A),
  get_agent_position(A,P),
  new_pos(P,_,Q),
  spiral([Q,P],Ps,_).
