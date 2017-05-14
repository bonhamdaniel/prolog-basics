% Knowledge Base for the Farmer
% Problem Expert System.
% ------------------------------------

% Facts - state space of the problem
start(e,e,e,e).
farmer_goat(X,X,Y,Y).
goat(X,_,X,X).
farmer_goat_wolf(X,X,_,X).
farmer_goat_cabbage_p2(X,X,X,_).
cabbage_p2(X,X,_,X).
wolf(X,X,X,_).
farmer_cabbage_wolf(X,_,X,X).
farmer_cabbage_wolf_p2(X,_,X,X).
cabbage_wolf(X,X,Y,Y).
cabbage_wolf_p2(X,X,Y,Y).
goal(w,w,w,w).
goal_p2(w,w,w,w).

% Root rule - displays solution paths when found
rule((path(Solution) :-
	(state(X), path(X, Solution))), 100).

% Rules used to dictate solution paths
rule((state(goal2) :-
	goal_p2(w,w,w,w)), 100).
rule((state(goal) :-
	goal(w,w,w,w)), 100).
rule((goal(X,X,X,X) :-
	cabbage_wolf(e,e,w,w)), 100).
rule((goal_p2(X,X,X,X) :-
	cabbage_wolf_p2(e,e,w,w)), 100).
rule((cabbage_wolf(e,e,w,w) :-
	farmer_cabbage_wolf(w,e,w,w)), 100).
rule((cabbage_wolf_p2(e,e,w,w) :-
	farmer_cabbage_wolf_p2(w,e,w,w)), 100).
rule((farmer_cabbage_wolf(w,e,w,w) :-
	wolf(e,e,e,w)), 100).
rule((farmer_cabbage_wolf_p2(w,e,w,w) :-
	cabbage_p2(e,e,w,e)), 100).
rule((wolf(e,e,e,w) :-
	farmer_goat_wolf(w,w,e,w)), 100).
rule((cabbage_p2(e,e,w,e) :-
	farmer_goat_cabbage_p2(w,w,w,e)), 100).
rule((farmer_goat_cabbage_p2(w,w,w,e) :-
	(multiple_solutions,
	goat(e,w,e,e))), 100).
rule((farmer_goat_wolf(w,w,e,w) :-
	goat(e,w,e,e)), 100).
rule((goat(e,w,e,e) :-
	farmer_goat(w,w,e,e)), 100).
rule((farmer_goat(w,w,e,e) :-
	start(e,e,e,e)), 100).
rule((start(X,X,X,X) :-
	start), 100).

%Rule used to mark end of a session
rule((state(shut_down) :-
	end), 100).

% Rules used to format display of solution paths
rule(path(goal, 'Solution #1: (e,e,e,e)-(w,w,e,e)-(e,w,e,e)-(w,w,e,w)-(e,e,e,w)-(w,e,w,w)-(e,e,w,w)-(w,w,w,w)'), 100).
rule(path(goal2, 'Solution #2: (e,e,e,e)-(w,w,e,e)-(e,w,e,e)-(w,w,w,e)-(e,e,w,e)-(w,e,w,w)-(e,e,w,w)-(w,w,w,w)'), 100).
rule(path(shut_down, 'Shutting down session execution.'), 100).

% Askables
askable(multiple_solutions).
askable(start).
askable(end).
