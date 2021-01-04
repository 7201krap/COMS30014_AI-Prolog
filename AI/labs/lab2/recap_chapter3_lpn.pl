% IMPORTANT NOTE : a :- b, c.
% a is true if b and c are true


% Example 1 : Eating
% 여기서 두가지 경우로 나뉜다.
% 방금 먹은것만 소화할지
% 아니면 먹은것을 소화시킨후, 한번더 소화 할지
is_digesting(X, Y) :- just_ate(X, Y).
is_digesting(X, Y) :-
  just_ate(X, Z),
  is_digesting(Z, Y).

just_ate(mosquito, blood(john)).
just_ate(frog, mosquito).
just_ate(stork, frog).

% Example 2 : Descendant
child(anne, bridget).
child(bridget, caroline). % caroline is a child of Bridget
child(caroline, donna).  % donna is a child of caroline
child(donna, emily).

descend(X, Y) :-
  child(X, Y).
descend(X, Y) :-
  child(X, Z),
  descend(Z, Y).

% Example 3 : Successor
numeral(0).
numeral(succ(X)) :-
  numeral(X).

% Example 4 : Addition
add(0, Y, Y).
add(succ(X), Y, succ(Z)) :-
  add(X, Y, Z).
