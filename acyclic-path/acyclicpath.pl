% Simple example program demonstrating
% accepting user input, some basic 
% graph manipulation, and using functions.
% ------------------------------------

start :- 
	write('Please enter the graph you would like searched: '),
	read(Graph),
	write('Please enter the start node for the desired path: '),
	read(A),
	write('Please enter the end node for the desired path: '),
	read(Z),
	path(Graph, A, Z, [A]).
path(_, N, N, P) :-
	write('Path is ['),
	writelist(P),
	!.
path(graph(Nodes, Edges), A, Z, P) :-
	member(c(A, N), Edges),
	not(member(N, P)),
	add_to_list(P, N, PP),
	path(graph(Nodes,Edges), N, Z, PP).
member(X, [X | _]).
member(X, [_ | T]) :-
	member(X, T).
writelist([ ]) :-
	write(']').
writelist([H | T]) :-
	size_of_list(T, 0),
	write(H),
	writelist(T).
writelist([H | T]) :-
	write(H),
	write(', '),
	writelist(T).
add_to_list([H | T], X, [H | NewT]) :-
	add_to_list(T, X, NewT).
add_to_list([ ], X, [X]).
size_of_list([ ], 0).
size_of_list([_ | T], N) :-
	size_of_list(T, NN),
	N is NN + 1.
