% < EX 1-1 >

% vINCENT --> atom
% Footmassage --> variable
% variable23 --> atom
% Variable2000 --> variable
% big_kahuna_burger --> atom
% 'big kahuna burger' --> atom
% big kahuna burger --> neither
% 'Jules' --> atom
% _Jules --> variable
% '_Jules' --> atom

% 정리:
% !! atom: 소문자로 시작, 또는 ' ' 로 묶여져 있는 형태
% !! variable: 대문자로 시작, 또는 _ 로 시작

% -----------------------------------------------------------------------------

% < EX 1-2 >

% loves(Vincent,mia)
% --> complex term (loves/2)

% 'loves(Vincent,mia)'
% --> variable

% Butch(boxer)
% --> not a term

% boxer(Butch)
% --> complex term, boxer/1

% and(big(burger),kahuna(burger))
% --> complex term, and/2

% and(big(X),kahuna(X))
% --> complex term, and/2

% _and(big(X),kahuna(X))
% --> not a term

% (Butch kills Vincent)
% kills(Butch Vincent)
% --> not a term

% kills(Butch,Vincent
% --> not a term

% 정리:
% !! term 은 반드시 소문자 함수로 시작 하여야 한다.
% !! variable 이 함수가 될수는 없다
% !! 함수가 시작했으면 반드시 괄호로 묶어 주어야 한다.
% !! 여러가지의 input 이 있을때는 반드시 comma (,) 로 띄워주어야 한다.
% -----------------------------------------------------------------------------

% < EX 1-3 >
% 7 predicates = woman/1 + man/1 + person/1 + loves/2 + father/2
% 7 clauses = 3 facts + 4 rules
% 3 facts
% woman(vincent).
% woman(mia).
% man(jules).

% 4 rules
% person(X) :- man(X); woman(X).
% loves(X,Y) :- father(X,Y).
% father(Y,Z) :- man(Y), son(Z,Y).
% father(Y,Z) :- man(Y), daughter(Z,Y).

% facts: 3
% rules: 4

% |     Head     |         Goals          |
% |--------------|------------------------|
% | person(X)    | man(X), woman(X)       |
% | loves(X, Y)  | father(X, Y)           |
% | father(Y, Z) | man(Y), son(Z, Y)      |
% | father(Y, Z) | man(Y), daughter(Z, Y) |

% < EX 1-4 >
% Butch is a killer.
killer(butch).
% Mia and Marsellus are married.
married(mia, marsellus).
% Zed is dead.
dead(zed).
% Marsellus kills everyone who gives Mia a footmassage.
kills(marsellus, X) :-
  footmassage(X, mia).
% Mia loves everyone who is a good dancer.
loves(mia, X) :-
  goodDancer(X).
% Jules eats anything that is nutritious or tasty.
eats(jules, X) :-
  nutritious(X);tasty(X).

% < EX 1-5 >
% Suppose we are working with the following knowledge base:
hasWand(harry).
quidditchPlayer(harry).
wizard(ron).
wizard(X) :-
  hasBroom(X), hasWand(X).
hasBroom(X) :-
  quidditchPlayer(X).

% wizard(Y). 를 하면 wizard 를 만족하는 모든 y 값이 나옴!!
% Y = ron;
% Y = harry.
