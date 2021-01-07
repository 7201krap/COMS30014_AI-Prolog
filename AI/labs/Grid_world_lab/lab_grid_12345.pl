% how to run
% ? swipl ailp.pl lab grid
% ? start.
% hit the 'run' button on the website
% ? shell.
% ? setup.

% True if A is a possible movement direction
m(n). m(s). m(e). m(w).

% True if p(X,Y) is on the board
on_board(p(X,Y)) :- ailp_grid_size(N), between(1,N,X), between(1,N,Y).

% True if p(X1,Y1) is one step in direction M from p(X,Y) (no bounds check)
pos_step(p(X,Y), north, p(X,Y1)) :- Y1 is Y-1.
pos_step(p(X,Y), east,  p(X1,Y)) :- X1 is X+1.
pos_step(p(X,Y), south, p(X,Y1)) :- Y1 is Y+1.
pos_step(p(X,Y), west,  p(X1,Y)) :- X1 is X-1.

% True if NPos is one step in direction M from Pos (with bounds check)
new_pos(P,D,Q) :- on_board(P), pos_step(P,D,Q), on_board(Q).

% True if a L has the same length as the number of squares on the board
complete(L) :- ailp_grid_size(N), N2 is N*N, length(L,N2).

% SPIRAL 은 어떻게 하는지 잘 모르겠다.
% Perform a sequence of moves creating a spiral pattern, return the moves as L

turn(north,east,clockwise).
turn(east,south,clockwise).
turn(south,west,clockwise).
turn(west,north,clockwise).

turn(D1,D2,anticlockwise) :-
  turn(D2,D1,clockwise).

% termination base case
% 결과값은 Qs 에 담긴다.
spiral(Ps,Qs,_) :-
  complete(Ps), !, reverse(Ps,Qs).

% start 에서 이쪽으로 넘어온다.
spiral([Q,P|Ps],Qs,S) :-
  new_pos(P,D,Q),
  (C=D ; turn(D,C,S)),
  new_pos(Q,C,R),
  \+ member(R,[P|Ps]),
  % 계속 termination base case 에 성립되는지 확인하다가
  % complete(Ps) 이 만족되면 termination base case 로 넘어간다.
  spiral([R,Q,P|Ps],Qs,S).

% start
spiral(Ps) :-
  my_agent(A),
  get_agent_position(A,P),
  new_pos(P,_,Q),
  spiral([Q,P],Ps,_).
