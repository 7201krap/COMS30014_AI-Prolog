even(0).
even(s(s(N))) :-
  even(N).

odd(s(X)) :-
  even(X).

p :- \+ q, r.
p :- q.
q.
r.

% sample answer for <part2-c>

% One possible scheme:
%
%   size = 50         # the image is size pixels wide and size pixels tall
%   offspring = copy(parent1)
%
%   pick four random values, each in the range [0,size): x1, y1, x2, y2
%   for x in range [x1, x2]:
%     for y in range [y1, y2]:
%       for z in [0,1,2]:
%         location =  (size*3*y)+(x*3)+z
%         offspring[location] = parent2[location]
%
% Lose a mark for not picking a random rectangle
% Lose a mark for messing up the loop
% Lose a mark for not over-writing one parent with values from the other
% Lose a mark for forgetting the "*3"
