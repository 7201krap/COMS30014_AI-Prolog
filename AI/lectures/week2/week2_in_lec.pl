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
% usage : ?- bagof(Person, likes_(Person, pizza), Bag).
% usage : ?- bagof(whoLikesPizza(Person), likes_(Person, pizza), Bag).

% But +Template Person 이 꼭 변수일 필요는 없다 !! 그냥 whoLikesPizza(Person) 이런식으로
% 해도 variable 이 함수 안에 들어있기만 하면 상관이 없음. whoLikesPizza(Person) 이런식으로
% 된다면 Bag 에도 whoLikesPizza(Person) 이런 형식으로 결과가 도출된다.

% But Object doesn’t have to be a variable,
% it may be a complex term that just contains a variable that also occurs in Goal .
% For example, we might decide that we want to build a new predicate fromMartha/1
% that is true only of descendants of Martha.

likes_(Human, pizza) :-
  italian(Human).

likes_(mary,  pizza).
likes_(marco, pizza).
italian(marco).



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
% 만약에 mary 대신에 random 한 이름 jason 으로 하면
% bagof   --> false 를 출력하고
% findall --> [] 를 출력한다.



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
