% how to run
% ? swipl ailp.pl lab grid
% ? start.
% hit the 'run' button on the website
% ? shell.
% ? setup.
% ? stop.

%        Query Name	                    Description
% start 	                       Initiate the web server
% shell 	                       Open the command shell
% my_agent(-A) 	                 Returns the ID of your Agent
% ailp_grid_size(-N) 	           Returns the size of the grid
% get_agent_position(+A,-Pos)    Returns the position of Agent A
% agent_do_moves(+A,+L) 	       Makes Agent A perform the list of moves L

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

% Perform a sequence of moves creating a spiral pattern, return the moves as L


% how to run
% ?- spiral([_|Ps]), my_agent(A), agent_do_moves(A,Ps).


turn(north,east,clockwise).
turn(east,south,clockwise).
turn(south,west,clockwise).
turn(west,north,clockwise).

turn(D1,D2,anticlockwise) :-
  turn(D2,D1,clockwise).

% termination base case
% 결과값은 Qs 에 담긴다.
spiral(Ps,Qs,_) :-
  write("----- new process 3 -----\n"),
  complete(Ps), !, reverse(Ps,Qs),

  % This final state only executes once at the last.
  write("FINAL PROCESS: Qs: "),
  write(Qs),
  write("\n").

% start 에서 이쪽으로 넘어온다.
spiral([Q,P|Ps],Qs,S) :-
  write("----- new process 2 -----\n"),
  write("INNER PROCESS: Ps: "),
  write(Ps),
  write("\n"),

  % This Qs is always emtpy here like [_5194|_5196].
  % Qs gets evaluated at the last.
  write("INNER PROCESS: Qs: "),
  write(Qs),
  write("\n"),

  % P = 현재 위치
  % Q = 다음 위치
  % P + D --> Q
  new_pos(P,D,Q),

  write("value of P(previous), Q(current), D(direction): "),
  write(P),
  write(" and "),
  write(Q),
  write(" and "),
  write(D),
  write("\n"),

  % D 에서 C 로 방향을 바꾸고 어떻게 바뀌었는지 S 에 저장됨.
  % 벽을 안만났을때, C = D
  % --> 1. new_pos(Q,C,R)에서 이게 만족이 안되면

  % 벽을 만났을때, turn(D,C,S)
  % --> 2. new_pos(Q,C,R)에서 이게 실행되어서 새로운값 C 를 찾아준다.
  (C=D ; turn(D,C,S)),

  % Q + C --> R
  new_pos(Q,C,R),

  write("value of Q(previous), R(current), C(direction): "),
  write(Q),
  write(" and "),
  write(R),
  write(" and "),
  write(C),
  write("\n"),

  % R 이 [P|Ps] 의 원소라면 false 반환. 따라서 반드시 새로운 위치 R 은 이전 장소이면 안됨.
  % 여기서 backtracking 이 일어나는것 같다.
  \+ member(R,[P|Ps]),

  % 계속 termination base case 에 성립되는지 확인하다가
  % complete(Ps) 이 만족되면 termination base case 로 넘어간다.
  spiral([R,Q,P|Ps],Qs,S).

% start
spiral(Ps) :-
  write("----- new process 1 -----\n"),
  my_agent(A),
  get_agent_position(A,P),
  new_pos(P,_,Q),

  write("START: Ps: "),
  write(Ps),
  write("\n"),

  % P = 현재 위치
  % Q = 다음 위치
  % Ps: [_5194|_5196]
  spiral([Q,P],Ps,_).

% how to run
% ?- spiral([_|Ps]), my_agent(A), agent_do_moves(A,Ps).
