% test_queries.pl
:- consult('family_tree').

run_tests :-
    writeln('Test 1: child(X, mike). Expected: david, emma'),
    child(X1, mike), writeln(X1), fail ; true,

    writeln('Test 2: sibling(susan, X). Expected: mike'),
    sibling(susan, X2), writeln(X2), fail ; true,

    writeln('Test 3: cousin(david, jake). Expected: true'),
    (cousin(david, jake) -> writeln(true) ; writeln(false)),

    writeln('Test 4: grandparent(john, X). Expected: david, emma, jake'),
    grandparent(john, X3), writeln(X3), fail ; true,

    writeln('Test 5: descendant(X, john). Expected: mike, susan, david, emma, jake'),
    descendant(X4, john), writeln(X4), fail ; true.
