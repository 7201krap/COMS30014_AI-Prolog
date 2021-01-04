% UNIFICATION, =

% When we write a goal like X = Y in Prolog, we are testing for more than simple
% equality in the mathematical sense. We are testing whether X (which might be a
% variable, an atom, or an arbitrarily complex term) unifies with Y (which might
% also be an atom, a variable, or a term). Two atoms, including numeric atoms,
% unify if they are the same. Two more complex terms unify if they have the same
% functor and their corresponding arguments unify. A variable always unifies with
% a term (provided that it is not previously unified with something different) by
% binding to that term.

% fred = fred
% X = fred
% X = likes(mary, pizza)
