% Simple example program demonstrating
% the breadth-first search strategy.
% ------------------------------------

test :-
	go(state(e, e, e, e), state(w, w, w, w)).
go(Start, Goal) :-
	empty_queue(Empty_open_queue),
	enqueue([Start, nil], Empty_open_queue, Open_queue),
	empty_set(Closed_set),
	path(Open_queue, Closed_set, Goal).
path(Open_queue, Closed_set, Goal) :-
	dequeue([State, Parent], Open_queue, _),
	State = Goal,
	write('A Solution is Found!'),
	nl,
	printsolution([State, Parent], Closed_set).
path(Open_queue, Closed_set, Goal) :-
	dequeue([State, Parent], Open_queue, Rest_open_queue),
	get_children(State, Rest_open_queue, Closed_set, Children),
	add_list_to_queue(Children, Rest_open_queue, New_open_queue),
	union([[State, Parent]], Closed_set, New_closed_set),
	path(New_open_queue, New_closed_set, Goal).
get_children(State, Rest_open_queue, Closed_set, Children) :-
	bagof(Child, moves(State, Rest_open_queue, Closed_set, Child), Children);
	Children = [ ].
moves(State, Rest_open_queue, Closed_set, [Next, State]) :-
	move(State, Next),
	not(unsafe(Next)),
	not(member_queue([Next, _], Rest_open_queue)),
	not(member_set([Next, _], Closed_set)).
empty_queue([ ]).
enqueue(E, [ ], [E]).
enqueue(E, [H | T], [H | Tnew]) :-
	enqueue(E, T, Tnew).
dequeue(E, [E | T], T).
member_queue([State, Parent], [[State, Parent] | _]).
member_queue(X, [_ | T]) :-
	member_queue(X, T).
add_list_to_queue(List, Queue, Newqueue) :-
	append(Queue, List, Newqueue).


move(state(X, G, X, C), state(Y, G, Y, C)) :-
	opp(X, Y),
	writelist(['try farmer - wolf']),
	nl.
move(state(X, X, W, C), state(Y, Y, W, C)) :-
	opp(X, Y),
	writelist(['try farmer - goat']),
	nl.
move(state(X, G, W, X), state(Y, G, W, Y)) :-
	opp(X, Y),
	writelist(['try farmer - cabbage']),
	nl.
move(state(X, G, W, C), state(Y, G, W, C)) :-
	opp(X, Y),
	writelist(['try farmer by self']),
	nl.
opp(e, w).
opp(w, e).
unsafe(state(X, Y, Y, _)) :- 
	opp(X, Y).
unsafe(state(X, Y, _, Y)) :-
	opp(X, Y).
writelist([ ]).
writelist([H | T]) :-
	write(H),
	write(' '),
	writelist(T).
printsolution([State, nil], _) :-
	write(State),
	nl.
printsolution([State, Parent], Closed_set) :-
	member_set([Parent, Grandparent], Closed_set),
	printsolution([Parent, Grandparent], Closed_set),
	write(State),
	nl.
member(X, [X | _]).
member(X, [_ | T]) :-
	member(X, T).
empty_set([ ]).
member_set([State, Parent], [[State, Parent] | _]).
member_set(X, [_ | T]) :-
	member_set(X, T).
delete_if_in_set(_, [ ], [ ]).
delete_if_in_set(E, [E | T], T) :-
	!.
delete_if_in_set(E, [H | T], [H | T_new]) :-
	delete_if_in_set(E, T, T_new), 
	!.
add_if_not_in_set(X, S, S) :-
	member(X, S),
	!.
add_if_not_in_set(X, S, [X | S]).
union([ ], S, S).
union([H | T], S, S_new) :-
	union(T, S, S2),
	add_if_not_in_set(H, S2, S_new),
	!.
