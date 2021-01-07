% 1
nu_1(X, Y) :-
  \+ (X = Y).

% 2
% For any Prolog goal,
% neg(Goal) will succeed precisely if Goal does not succeed.
neg(Goal) :-
  Goal,!,fail.
neg(Goal).

nu_2(X, Y) :-
  neg(X = Y).

% 3
nu_3(X,X) :-
	!,fail.
nu_3(_,_).

% 4
unifiable([H | List1], Term, List2) :-
  write('First'),
  \+ H = Term, !,
  write('Enter Cut'),
  unifiable(List1, Term, List2).

unifiable([H | List1], Term, [H | List2]) :-
  write('Second'),
  unifiable(List1, Term, List2).

unifiable([],Term,[]).