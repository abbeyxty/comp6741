% reference；https://github.com/kstarzyk/numberlink-solver/blob/master/numberlink.pl

solve( Row, _K, Pairs, Solution ) :-
generate_Matrix( Row, Row, Matrix ),
initMatrix( Pairs, Matrix ),
findSolution(Pairs, Matrix, Solution ).

generate_Matrix( Row, Col, Matrix ) :-
generate_Matrix( Row, Col, Matrix, [] ).
generate_Matrix( 0, _, Matrix, Matrix ) :- !.
generate_Matrix( Row, Col, Matrix, 	Acc ) :-
Xum is Row - 1,
length( H, Col ),
generate_Matrix( Xum, Col, Matrix, [H|Acc] ).

initMatrix( Pairs, Matrix ) :-
initMatrix( Pairs, Matrix, 1 ).
initMatrix( [E|Pairs], Matrix, Acc ) :-
E = (_Number: (X1, Y1), (X2, Y2)),
row( Matrix, X1, Z ),
nth1( Y1, Z, Acc ),
row( Matrix, X2, Col ),
nth1( Y2, Col, Acc ),
XextAcc is Acc + 1,
initMatrix( Pairs, Matrix, XextAcc ).
initMatrix( [], _Matrix, _ ).

findSolution( Pairs, Matrix, Routes ) :-
findSolution( Pairs, Matrix, Routes, 1 ).

findSolution( [H|T],Matrix,[Acc:Route|Solution], Acc ) :-
H =(_Number: (SX,SY), (DX,DY)),
findPath( SX, SY, DX, DY, Matrix, Route, Acc),
XextAcc is Acc + 1,
length(Route,Row),
Row \== 0,
fillWithXum( Matrix, Route, Acc ),
findSolution( T, Matrix, Solution, XextAcc ).

findSolution( [], _Matrix,  [] , _ ) :- !.


findPath( X1, Y1, X2, Y2, Matrix, [ (X1, Y1) | Route ], Acc ) :-
findPath( X1, Y1, X2, Y2, Matrix,  Route, [(X2, Y2)], Acc ).

findPath( X1, Y1, X2, Y2, Matrix, Route, Route, Acc ) :-
(X1,Y1) \== (X2,Y2),
move( X1, Y1, X2, Y2, Matrix, Acc ).

findPath( X1, Y1, X2, Y2, Matrix, Route, Visited, Acc ) :-
(X1,Y1) \== (X2,Y2),
move( X, Y, X2, Y2, Matrix, Acc),
\+ member( (X, Y), Visited ),
findPath(X1, Y1,X, Y, Matrix, Route, [(X, Y)|Visited ], Acc ).

% move ( +X1, +Y1, +X2, +Y2 )
move( X1, Y1, X2, Y2, Matrix, Acc ) :-
node( Matrix, X2, Y2, Acc ),
X1 is X2,
Y1 is Y2 - 1.
move( X1, Y1, X2, Y2, Matrix, Acc ) :-
node( Matrix, X2, Y2, Acc ),
X1 is X2,
Y1 is Y2 + 1.
move( X1, Y1, X2, Y2, Matrix, Acc ) :-
node( Matrix, X2, Y2, Acc ),
X1 is X2 + 1,
Y1 is Y2.
move( X1, Y1, X2, Y2, Matrix, Acc ) :-
node( Matrix, X2, Y2, Acc ),
X1 is X2 - 1,
Y1 is Y2.

node( Matrix, X, Y, Value ) :-
row( Matrix, X, Z ),
nth1( Y, Z, Value ).

putXum( Matrix, (X, Y), Xum) :-
row( Matrix, X, Z ),
nth1( Y, Z, Row ),
Row is Xum.

fillWithXum( Matrix, [H|T], Xum ) :-
H = (_,_),
putXum(Matrix, H, Xum),
fillWithXum( Matrix, T, Xum ).
fillWithXum( _Matrix, [], _ ).

row( [_|Rest], X, List ) :-
X > 1,
DecX is X - 1,
row( Rest, DecX, List ).
row( [T|_], 1, T).
