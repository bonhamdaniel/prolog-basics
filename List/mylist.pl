% Simple example program demonstrating
% accepting user input, basic list
% operations, and using functions.
% ------------------------------------

start :- 
	write('Please enter an int: '),
	read(X),
	write('Please enter a list of ints: '),
	read(L),
	checklist(X, L, 0, []).
checklist(_, [], _, R) :-
	write('Result = ['),
	writelist(R),
	write(']').
checklist(X, [X|T], I, R) :- 
	II is I + 1,
	add_to_list(R, II, RR),
	checklist(X, T, II, RR).
checklist(X, [_|T], I, R) :- 
	II is I + 1, 
	checklist(X, T, II, R).
writelist([]).
writelist([H|T]) :-
	size_of_list(T, 0),
	write(H),
	writelist(T).
writelist([H|T]) :-
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
