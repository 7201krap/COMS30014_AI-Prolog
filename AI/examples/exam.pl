% Prolog comes with a built-in predicate that carries out
% standard unification
% (that is, unification with the occurs check).

% The predicate is: unify_with_occurs_check/2.

% For example: unify_with_occurs_check(father(X),X).

% ------------------------------------------------------------

% X  =  father(X),  Y  =  father(Y),  X  =  Y.

% would result in a crash (note that the X = Y demands
% that we unify two finite representations of infinite terms).
% Nonetheless, in some modern systems unification works
% robustly with such representations (for example, both SWI
% and Sicstus can handle the previous example) so you can
% actually use them in your programs.
