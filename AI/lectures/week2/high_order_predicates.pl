% First example
foo(a, b, c).
foo(a, b, d).
foo(b, c, e).
foo(b, c, f).

% bagof(C, foo(A, B, C), Cs).
% bagof(C, A^foo(A, B, C), Cs).

% Second example
age(harry,13).
age(draco,14).
age(ron,13).
age(hermione,13).
age(dumbledore,60).
age(hagrid,30).

% ?- bagof(X, Y^age(X, Y), Xs).
% ?- findall(X, age(X, Y), Xs).

% ?- setof(X, Y^age(X, Y), Xs).



% 1. bagof(X, Y^age(X, Y), Xs).
% Xs = [harry, draco, ron, hermione, dumbledore, hagrid].
% 2. findall(X, age(X, Y), Xs).
% Xs = [harry, draco, ron, hermione, dumbledore, hagrid].
% 위 두개는 같은 결과를 낸다

% 3. setof(X, Y^age(X, Y), Xs).
% Xs = [draco, dumbledore, hagrid, harry, hermione, ron].
% 이거는 같은 결과를 내지만 sorting 을 해준다.
% 앞에 ^ 이거는 쉽게 말해서
% "don't worry about generating a separate list for each value of Y"
% And just act like findall



% ?- setof(Y, X^age(X, Y), Xs).
% Xs = [13, 14, 30, 60].
% 이거는 소팅을 해줌과 동시에 중복을 없앤다.
%
% ?- bagof(Y, X^age(X, Y), Xs).
% Xs = [13, 14, 13, 13, 60, 30].
%
% ?- findall(Y, age(X, Y), Xs).
% Xs = [13, 14, 13, 13, 60, 30].
% 위 두개는 정확히 동일한 일을 한다. 
