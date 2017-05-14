% Simple example program demonstrating
% accepting user input, basic graph 
% manipulation, and using functions.
% ------------------------------------

edge(a, b, 3).
edge(b, c, 1).
edge(b, d, 5).
edge(c, d, 2).
edge(d, b, 2).

start :-
	write('Please enter the start node for the desired path: '),
	read(X),
	write('Please enter the end node for the desired path: '),
	read(Y),
	cheapest_path(X, Y).
cheapest_path(X, Y) :-
	path_cost(X, Y, Path, Min_Cost),
	not(cheaper_path(X, Y, _, _, Min_Cost)),
	display_result(X, Y, Path, Min_Cost),
	!.
path_cost(X, Y, Path, Cost) :-
	path_one_cost(X, [Y], 0, Path, Cost).
path_one_cost(X, [X | Path1], Cost1, [X | Path1], Cost1).
path_one_cost(X, [Y | Path1], Cost1, Path, Cost) :-
	edge(N, Y, Edge_Cost),
	not(member(N, Path1)),
	Cost2 is Cost1 + Edge_Cost,
	path_one_cost(X, [N, Y | Path1], Cost2, Path, Cost).
cheaper_path(X, Y, Path, Cost, Min_Cost) :-
	path_cost(X, Y, Path, Cost),
	Cost < Min_Cost.
display_result(X, Y, Path, Min_Cost) :-
	write('the minimum path between '),
	write(X),
	write(' and '),
	write(Y),
	write(' is ['),
	writelist(Path),
	write(' with cost = '),
	write(Min_Cost).
member(X,[X | _]).
member(X,[_ | T]) :-
	member(X, T).
writelist([ ]) :-
	write(']').
writelist([H | T]) :-
	size_of_list(T, 0),
	write(H),
	writelist(T).
writelist([H|T]) :-
	write(H),
	write(','),
	writelist(T).
size_of_list([ ], 0).
size_of_list([_ | T], N) :-
	size_of_list(T, NN),
	N is NN + 1.
