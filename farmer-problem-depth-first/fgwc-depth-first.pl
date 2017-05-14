% Simple example program demonstrating
% the depth-first search strategy.
% ------------------------------------

initial(state(e, e, e, e)).

test :-
	go(state(e, e, e, e), state(w, w, w, w)).
go(Start, Goal) :-
	empty_stack(Empty_open),
	stack([Start, nil], Empty_open, Open_stack),
	empty_set(Closed_set),
	path(Open_stack, Closed_set, Goal).
path(Open_stack, Closed_set, Goal) :-
	stack([State, Parent], _, Open_stack),
	State = Goal,
	write('A Solution is Found!'),
	nl,
	printsolution([State, Parent], Closed_set).
path(Open_stack, Closed_set, Goal) :-
	stack([State, Parent], Rest_open_stack, Open_stack),
	get_children(State, Rest_open_stack, Closed_set, Children),
	add_list_to_stack(Children, Rest_open_stack, New_open_stack),
	union([[State, Parent]], Closed_set, New_closed_set),
	path(New_open_stack, New_closed_set, Goal).
get_children(State, Rest_open_stack, Closed_set, Children) :-
	bagof(Child, moves(State, Rest_open_stack, Closed_set, Child), Children);
	Children = [ ].
moves(State, Rest_open_stack, Closed_set, [Next, State]) :-
	move(State, Next),
	not(unsafe(Next)),
	not(member_stack([Next, _], Rest_open_stack)),
	not(member_set([Next, _], Closed_set)).
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
empty_stack([ ]).
stack(Top, Stack, [Top | Stack]).
member_stack([State, Parent], [[State, Parent] | _]).
member_stack(X, [_ | T]) :-
	member_stack(X, T).
add_list_to_stack(List, Stack, Result) :-
	append(List, Stack, Result).
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
