% closed-world example (assume false facts for which there is no evidence of truth)
happy_(diego) :- \+ sees(diego, cheese_sandwich).

% facts (evidence) does not contain anything related to cheese_sandwich
sees(random_guy, something).

% facts (evidence) does contain a thing related to cheese_sandwich
% sees(diego, cheese_sandwich).



% ancestor relationship
father(adam, cain).
father(adam, abel).
father(adam, seth).
father(cain, enoch).
father(enoch, irad).

ancestor(X, Y) :- father(X, Y).
ancestor(X, Y) :- father(X, Z), ancestor(Z, Y).



% bagof/3
% built-in predicate bagof(+Template, +Goal, -Bag) is used to collect a list of Bag of all the itmes Template that statisfy some goal.
% Bag 의 원소는 중복될 수 있다.
% usage : ?- bagof(Person, likes(Person, pizza), Bag).

% likes(Human, pizza) :-
%   italian(Human).
%
% likes(mary,  pizza).
% likes(marco, pizza).
% italian(marco).



% setof/3
% The built-in Prolog predicate setof(+Template, +Goal, -Set) binds Set to the list of all instances of Template satisfying the goal Goal.
% set 은 중복될 수 없다.
% usage : setof(Y, happy(Y), Set).
happy(X) :-
  rich(X).

happy(fido).
happy(harry).
rich(harry).


% 이 예시도 해보기
% usage : bagof(Person, happy(Person), Bag).
% usage : setof(Person, likes(Person, pizza), Set).
% usage : findall(Person, likes(Person, pizza), List).
% usage : findall(Person, happy(Person), List)



% findall/3
% built-in predicate findall(+Template, +Goal, -List) is used to collect a list List of all the items Template that satisfy some goal Goal.
% usage : findall(Person, likes(Person, pizza), Bag).
% Another difference between bagof/3 and findall/3 is
% ** the extent of backtracking done ** before the third parameter (List).

believes(john,  likes(mary, pizza)).
believes(frank, likes(mary, fish)).
believes(john,  likes(mary, apples)).
believes(frank, likes(mary, pork)).
believes(frank, likes(mary, meat)).

% usage1 : bagof(likes(mary, X), believes(_, likes(mary, X)), Bag).
% usage2 : findall(likes(mary, X), believes(_, likes(mary, X)), List).
% usage1 과 2 의 차이점:
% bagof (usage1) 를 했을때는 john 이 좋아하는거 따로, frank 가 좋아하는거 따로 분리해서 출력.
% findall (usage2) 을 했을때는 john 이 좋아하는 것과 frank 가 좋아하는 것을 분리해주지 않는다.
% 그냥 한번에 출력함.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% between/3 : between(Bottom, Top, Int) is true if and only if Bottom =< Int =< Top.
% If Int is an unbounded variable, it will be bounded to every integer in the range [Bottom, Top].



% maplist/2
% maplist( +Goal (callable_term), +List )
% maplist(Goal, List) is true if and only if Goal can be successfully applied to List. If Goal fails for any of List's elements, maplist fails.
% usage 1 : maplist(even, [2, 4, 6]).
% usage 2 : maplist(even, [2, 4, 5]).
even(X) :-
  0 is X mod 2.



% maplist/3
% maplist( +Goal (callable_term), +List, +List )
% As in maplist/2, but operating on pairs of elements from the two lists. In this case, the Goal will consume a couple of elements each time, one from each list.
succ(X, Y) :-
  Y is X + 1.



% include/3
% include(Goal, List, FilterList) is true if and only if
% FilterList is a list containing only the elements of List that satisfy Goal.
