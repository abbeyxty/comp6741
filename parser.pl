parse :-
    parse(1).

parse(I) :-
    sentence(I, Words),
    parse_sentence(Words).

parse_sentence(Words) :-
    findall(P-T, s(P, T, Words, []), Parses),
    print_sentence(Words),
    print_parses(Parses).

print_sentence(Words) :-
    print('Sentence:'),
    print_words(Words),
    nl.

print_words([]).
print_words([W|Ws]) :-
    print(' '),
    print(W),
    print_words(Ws).

print_parses([]).

print_parses([P-T|Parses]) :-
    print('Probability: '),
    print(P),
    nl,
    print_tree(T,0),
    print_parses(Parses).

print_tree(T,N) :-
    T =.. [F,A],
    atom(A),
    !,
    indent(N),
    print(F),
    print('-'),
    print(A),
    nl.

print_tree(T,N) :-
    T =.. [F|Args],
    indent(N),
    print(F),
    nl,
    M is N+2,
    print_trees(Args,M).

print_trees([],_).

print_trees([T|Ts],N) :-
    print_tree(T,N),
    print_trees(Ts,N).
   
indent(0) :- !.
 
indent(N) :- 
    print(' '),
    M is N-1,
    indent(M).

   
