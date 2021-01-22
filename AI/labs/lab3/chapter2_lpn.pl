% 2.1 Unification
% x 값이 서로 같으면 vertical 하다
vertical(line(point(X,Y),point(X,Z))).

% y 값이 서로 같다면 horizontal 하다.
horizontal(line(point(X,Y),point(Z,Y))).

% 2.2 Proof Search

% knowledge base
% example 1
f(a).
f(b).
g(a).
g(b).
h(b).

k(X) :- f(X), g(X), h(X).

% example 2
loves(vincent, mia).
loves(marcellus, mia).

jealous(A, B) :-
  loves(A, C),
  loves(B, C).
