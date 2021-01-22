%% 예제 8 recursive
factorial(0, 1) :- !.
factorial(N, A) :-
  N > 0,
  Nnew is N-1,  % 여기서 주의 하여야 할 점은 바로 (밑에줄에 Nnew 대신)
                % N-1 을 넣으면 unify 로 인식하고
                % 그 값을 대입하지 않는다.
                % 따라서 다음과 같이 is 를 통하여 대입 하여 주어야 한다.
  factorial(Nnew, Anew),
  A is Anew * N.

%% 예제 9 power
% power(+N, +P, -A).
power(_, 0, 1) :-
  !.
power(N, P, A) :-
  % + 에 대한 정보는 power 위에다가
  P > 0,
  Pnew is P - 1,
  power(N, Pnew, Anew),

  % - 에 관한 정보는 power 밑에다가
  A is Anew * N.
