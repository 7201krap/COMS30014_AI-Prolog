% week2_in_lec.pl 과 같이 볼것

child(martha,charlotte).
child(charlotte,caroline).
child(caroline,laura).
child(laura,rose).

descend(X,Y)  :-
  child(X,Y).

descend(X,Y)  :-
  child(X,Z),
  descend(Z,Y).

% to find the length of the list generated from findall
% usage: findall(X, descend(martha, X), Z), length(Z, N).
% however, if we are not interested in what values does Z has,
% findall(Y, descend(martha, X), Z), length(Z, N). is possible


% findall vs bagof

% usage: findall(Child,descend(Mother,Child),List).
% usage: bagof(Child,descend(Mother,Child),List).

% usage: bagof(Child,descend(Mother,Child),List).
% 이거는 4개의 솔루션이 있다. 하지만 이것을 하나의 리스트로 만들고 싶다면?
% findall(List, bagof(Child,descend(Mother,Child),List), Z).

% setof

% The setof/3 predicate is basically the same as bagof/3 ,
% but with one useful difference: the lists it contains are ordered
% and contain no redundancies (that is, no list contains repeated items).

age(harry,13).
age(draco,14).
age(ron,13).
age(ron,13).
age(ron,13).
age(hermione,13).
age(hermione,13).
age(dumbledore,60).
age(hagrid,30).

% 이름에 대해서 관심이 있다. 다음 3개의 차이점을 알것.
% findall(X,age(X,Y),Out).
% bagof(X,age(X,Y),Out).
% setof(X,age(X,Y),Out).

% But maybe we would like the list to be ordered.
% We can achieve this with the following query:
% setof(X,Y^age(X,Y),Out). % list is alphabetically ordered, 나이에 대해서 신경쓰지 않는다.


% 나이에 대해서 관심이 있다.
% findall(Y,age(X,Y),Out).
% setof(Y,X^age(X,Y),Out). % list is in ascending order, 이름에 대해서 신경쓰지 않는다.
