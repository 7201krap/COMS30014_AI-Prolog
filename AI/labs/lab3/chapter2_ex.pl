% Exercises

% ex 2.1
% 되는거는 true 안되는 거는 false
% 1. bread  =  bread.
% --> true
% 2. ’Bread’  =  bread.
% --> false
% 3. ’bread’  =  bread.
% --> true
% 4. Bread  =  bread. **
% --> true
% 5. bread  =  sausage.
% --> false
% 6. food(bread)  =  bread.
% --> false
% 7. food(bread)  =  X.
% --> true
% 8. food(X)  =  food(bread).
% --> true
% 9. food(bread,X)  =  food(Y,sausage).
% --> true
% 10. food(bread,X,beer)  =  food(Y,sausage,X).
% --> false
% 11. food(bread,X,beer)  =  food(Y,kahuna_burger).
% --> false
% 12. food(X)  =  X.
% --> true
% 13. meal(food(bread),drink(beer))  =  meal(X,Y).
% --> true
% 14. meal(food(bread),X)  =  meal(X,drink(beer)).
% --> false.

% ex 2.2
% facts
house_elf(dobby).
witch(hermione).
witch('McGonagall').
witch(rita_skeeter).
wizard(none).

magic(X):-
  house_elf(X).
magic(X):-
  witch(X).
magic(X):-
  wizard(X).


% ?-  magic(house_elf).
% --> false

% ?-  wizard(harry).
% --> false

% ?-  magic(wizard).
% --> false

% ?-  magic(’McGonagall’).
% --> true.

% ?-  magic(Hermione).
% --> true

% ex 2.3
% facts
word(determiner,a).
word(determiner,every).
word(noun,criminal).
word(noun, 'big kahuna burger').
word(verb,eats).
word(verb,likes).

sentence(Word1,Word2,Word3,Word4,Word5):-
  word(determiner,Word1),
  word(noun,Word2),
  word(verb,Word3),
  word(determiner,Word4),
  word(noun,Word5),
  write('Sentence --> '), write(Word1 ), write(' '), write(Word2), write(' '), write(Word3), write(' '), write(Word4), write(' '), write(Word5), nl.

% ex 2.4

word(astante,  a,s,t,a,n,t,e).
word(astoria,  a,s,t,o,r,i,a).
word(baratto,  b,a,r,a,t,t,o).
word(cobalto,  c,o,b,a,l,t,o).
word(pistola,  p,i,s,t,o,l,a).
word(statale,  s,t,a,t,a,l,e).

crossword(V1, V2, V3, H1, H2, H3) :-
  word(V1, _,_11,_,_21,_,_31,_),
  word(V2, _,_12,_,_22,_,_32,_),
  word(V3, _,_13,_,_23,_,_33,_),
  word(H1, _,_11,_,_12,_,_13,_),
  word(H2, _,_21,_,_22,_,_23,_),
  word(H3, _,_31,_,_32,_,_33,_).
