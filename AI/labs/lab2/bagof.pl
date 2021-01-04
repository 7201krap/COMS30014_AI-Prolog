likes(mary, pizza).
likes(marco, pizza).
likes(Human, pizza) :-
  italian(Human).

italian(marco).

% ?- bagof(Person, likes(Person, pizza), Bag).
% Bag = [mary, marco, marco].

% Bag 안에다가 'Goal == likes(Person, pizza)' 을 만족하는 모든 Person 의 경우를 다 집어 넣음. 
