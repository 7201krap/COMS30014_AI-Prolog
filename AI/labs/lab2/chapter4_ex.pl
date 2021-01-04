% ex 4.1

%[a,b,c,d]  =  [a,[b,c,d]].
% --> false
%[a,b,c,d]  =  [a|[b,c,d]].
% --> true
%[a,b,c,d]  =  [a,b,[c,d]].
% --> false
%[a,b,c,d]  =  [a,b|[c,d]].
% --> true
%[a,b,c,d]  =  [a,b,c,[d]].
% --> false
%[a,b,c,d]  =  [a,b,c|[d]].
% --> true
%[a,b,c,d]  =  [a,b,c,d,[]].
% --> false
%[a,b,c,d]  =  [a,b,c,d|[]].
% --> true
%[]  =  _.
% --> true
%[]  =  [_].
% --> false
%[]  =  [_|[]].
% --> false

% ex 4.2

%[1|[2,3,4]]
%[1,2,3|[]]
%[1|2,3,4]
% --> false
%[1|[2|[3|[4]]]]
%[1,2,3,4|[]]
%[[]|[]]
%[[1,2]|4]
% --> false
%[[1,2],[3,4]|[5,6,7]]

% ex 4.3
% Write a predicate second(X,List) which checks whether X is the second element of List .

second(X,[_,X|_]).

% ex 4.4
% Write a predicate swap12(List1,List2) which checks whether List1 is identical to List2 ,
% except that the first two elements are exchanged.

swap12(ListX, ListY) :-
  ListX = [X0, X1 | T1],
  ListY = [X1, X0 | T2],
  T1 == T2.

% ex 4.5

tran(eins,one).
tran(zwei,two).
tran(drei,three).
tran(vier,four).
tran(fuenf,five).
tran(sechs,six).
tran(sieben,seven).
tran(acht,eight).
tran(neun,nine).

listtran([], []).
listtran(G,E) :-
  G = [G0 | GT],
  E = [E0 | ET],
  tran(G0, E0),
  listtran(GT, ET).

% ex 4.6
twice_([], []).
twice_([I0 | IT],[I0, I0 | OT]) :-
  twice_(IT, OT).
