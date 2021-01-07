% Try to write queries in your terminal that:

% 1. Find all the adjacent cells around position P (giving multiple solutions)
% --> map_adjacent(p(1,5), AdjPos, OID).

% 2. Find all the adjacent cells around position P (as a List)
% --> findall(AdjPos, (map_adjacent(p(1,5), AdjPos, OID)), AdjPosList).

% 3. Find ONLY the empty cells around position P
% --> findall(AdjPos, (map_adjacent(p(1,5), AdjPos, OID), OID='empty'), AdjPosList).

% 4. Find the empty cells next to your agent
% --> findall(AdjPos, (my_agent(A), get_agent_position(A, Pos),
%             map_adjacent(Pos, AdjPos, empty)), AdjList).

% 5. Find the OID of the oracle
% --> map_adjacent(p(8,5), AdjPos, o(1)).

% -----------------------------------------------------------------------------
% < Possible Queries >

% % my_agent(-A)
% --> Returns the ID of your Agent

% % ailp_grid_size(-N)
% --> Returns the size of the grid

% % get_agent_position(+A,-Pos)
% --> Returns the position of Agent A

% % agent_do_moves(+A,+L)
% --> Makes Agent A perform the list of moves L

% % map_adjacent(+Pos,?AdjPos,?OID)
% --> Returns positions adjacent to Pos and their OID

% -----------------------------------------------------------------------------
% 실행방법
% start., click run on the website, shell., setup.
% run search_bf in the terminal.

% Test if the objective has been completed at a given position
% This predicate should be true if the position is adjacent to an oracle
% oracle 이 근처에 있으면 true  를 반환한다.
% oracle 이 근처에 없다면 false 를 반환한다.
complete(P) :-
    map_adjacent(P, _, o(_)).

% Perform a BFS to find the nearest oracle
search_bf :-
  my_agent(A), get_agent_position(A,P),
  search_bf([P:[]], [], [P|Path]), % 이게 성공하면
  !,  % ! 으로 넘와서 다시 위로 돌아가지 않음. avoid backtracking.
  agent_do_moves(A,Path). % 모든 queue 를 만든 다음에 한번에 agent 를 움직임.

% stopping condition (base case)
search_bf([Pos:RPath|_],_,Path) :-
  % complete(Pos): Pos 근처에 oracle 이 있고,
  %
  complete(Pos), reverse([Pos|RPath],Path), !.

search_bf([Pos:RPath|Queue],Visited,Path) :-
  % NewPos: 갈수있는 새로운 좌표
  % Pos   : 현재(Parent) 좌표
  findall(NewPos:[Pos|RPath],
  (
    % NewPos 를 반환. OID가 empty 한 NewPos 를 뽑는다.
    map_adjacent(Pos, NewPos, empty),
    % 그 뽑힌 새로운 좌표 NewPos 는 visited 이면 안된다.
    \+ member(NewPos, Visited),
    % 그 뽑힌 새로운 좌표 NewPos 는 Queue 에 들어있으면 안된다.
    \+ member(NewPos:_, Queue)
  ),
  Children),

  write("\n"),
  write("Children: "),
  write(Children),
  write("\n"),

  % Children(새로 생성된것) 을 항상 Queue 뒤에다가 넣음.
  append(Queue,Children,NewQueue),
  write("\n"),
  write("New Queue: "),
  write(NewQueue),
  write("\n"),

  write("\n"),
  write("Visited: "),
  write(Visited),
  write("\n"),

  write("\n"),
  write("Pos: "),
  write(Pos),
  write("\n"),
  write("----------------------------------------------------\n"),
  search_bf(NewQueue,[Pos|Visited],Path).
