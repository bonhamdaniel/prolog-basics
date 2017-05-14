% Simple expert shell modified from
% "AI Algorithms, Data Structures, and
% Idioms in Prolog, Lisp, and Java"
% Chapter 6 - EXSHELL.
% ------------------------------------

% Prompts user for knowledge base file
run :-
	write('Please enter the name of the file containing the knowledge base.'),
	read(Filename),
	consult(Filename).

% solve/2 predicate
solve(Goal, CF) :-
	print_instructions,
	retractall(known(_, _)),
	solve(Goal, CF, [ ], 20).

% print_instructions predicate
print_instructions :-
	nl,
	write('Response must be either:'),
	nl,
	write('Confidence in truth of query.'),
	nl,
	write('A number between -100 and 100.'),
	nl,
	write('why.'),
	nl,
	write('how(X), where X is a goal'),
	nl.

% Different Cases for the solve/4 predicate
% Case 1: truth value of goal is already known
solve(Goal, CF, _, Threshold) :-
	known(Goal, CF),
	!,
	above_threshold(CF, Threshold).
% Case 2: negated goal
solve(not(Goal), CF, Rules, Threshold) :-
	!,
	invert_threshold(Threshold, New_threshold),
	solve(Goal, CF_goal, Rules, New_threshold),
	negate_cf(CF_goal, CF).
% Case 3: conjunctive goals
solve((Goal_1, Goal_2), CF, Rules, Threshold) :-
	!,
	solve(Goal_1, CF_1, Rules, Threshold),
	above_threshold(CF_1, Threshold),
	solve(Goal_2, CF_2, Rules, Threshold),
	above_threshold(CF_2, Threshold),
	and_cf(CF_1, CF_2, CF).
% Case 4: back chain on a rule in knowledge base
solve(Goal, CF, Rules, Threshold) :-
	rule((Goal :- (Premise)), CF_rule),
	solve(Premise, CF_premise, [rule((Goal :- Premise), CF_rule) | Rules], Threshold),
	rule_cf(CF_rule, CF_premise, CF),
	above_threshold(CF, Threshold).
% Case 5: fact assertion in knowledge base
solve(Goal, CF, _, Threshold) :-
	rule(Goal, CF),
	above_threshold(CF, Threshold).
% Case 6: ask user
solve(Goal, CF, Rules, Threshold) :-
	askable(Goal),
	askuser(Goal, CF, Rules),
	!,
	assert(known(Goal, CF)),
	above_threshold(CF, Threshold).

% Predicates for computing certainty factors
and_cf(A, B, A) :-
	A =< B.
and_cf(A, B, B) :-
	B < A.
negate_cf(CF, Negated_CF) :-
	Negated_CF is -1 * CF.
rule_cf(CF_rule, CF_premise, CF) :-
	CF is (CF_rule * CF_premise / 100).
above_threshold(CF, T) :-
	T >= 0,
	CF >= T.
above_threshold(CF, T) :-
	T < 0,
	CF =< T.
invert_threshold(Threshold, New_threshold) :-
	New_threshold is -1 * Threshold.

% askuser predicate
askuser(Goal, CF, Rules) :-
	nl,
	write('User query:'),
	write(Goal),
	nl,
	write('?'),
	read(Answer),
	respond(Answer, Goal, CF, Rules).

% Different Cases for the respond/4 predicate
% Case 1: user enters a valid confidence factor
respond(CF, _, CF, _) :-
	number(CF),
	CF =< 100,
	CF >= -100.
% Case 2: user enters a why query
respond(why, Goal, CF, [Rule | Rules]) :-
	write_rule(Rule),
	askuser(Goal, CF, Rules).
respond(why, Goal, CF, [ ]) :-
	write('Back to top of rule stack.'),
	askuser(Goal, CF, [ ]).
% Case 3: user enters a how query.  Build/print proof
respond(how(X), Goal, CF, Rules) :-
	build_proof(X, CF_X, Proof),
	!,
	write(X),
	write('concluded with certainty '),
	write(CF_X),
	nl,
	nl,
	write('The proof is '),
	nl,
	nl,
	write_proof(Proof, 0),
	nl,
	nl,
	askuser(Goal, CF, Rules).
% Case 4: user enters a query, could not build proof
respond(how(X), Goal, CF, Rules) :-
	write('The truth of '),
	write(X),
	nl,
	write('is not yet known.'),
	nl,
	askuser(Goal, CF, Rules).
% Case 5: user presents unrecognized input
respond(_, Goal, CF, Rules) :-
	write('Unrecognized response.'),
	nl,
	askuser(Goal, CF, Rules).

% build_proof/3 predicate - constructs a proof tree
build_proof(Goal, CF, (Goal, CF :- given)) :-
	known(Goal, CF),
	!.
build_proof(not(Goal), CF, Proof) :-
	!,
	build_proof(Goal, CF_goal, Proof),
	negate_cf(CF_goal, CF).
build_proof((Goal_1, Goal_2), CF, (Proof_1, Proof_2)) :-
	!,
	build_proof(Goal_1, CF_1, Proof_1),
	build_proof(Goal_2, CF_2, Proof_2),
	and_cf(CF_1, CF_2, CF).
build_proof(Goal, CF, (Goal, CF :- Proof)) :-
	rule((Goal :- Premise), CF_rule),
	build_proof(Premise, CF_premise, Proof),
	rule_cf(CF_rule, CF_premise, CF).
build_proof(Goal, CF, (Goal, CF :- fact)) :-
	rule(Goal, CF).

% User Interface
% write_rule predicate
write_rule(rule((Goal :- (Premise)), CF)) :-
	write(Goal),
	write(':-'),
	nl,
	write_premise(Premise),
	nl,
	write('CF = '),
	write(CF),
	nl.
write_rule(rule(Goal, CF)) :-
	write(Goal),
	nl,
	write('CF = '),
	write(CF),
	nl.
% write_premise predicate - writes the conjuncts of a rule premise
write_premise((Premise_1, Premise_2)) :-
	!,
	write_premise(Premise_1),
	write_premise(Premise_2).
write_premise(not(Premise)) :-
	!,
	write(' '),
	write(not),
	write(' '),
	write(Premise),
	nl.
write_premise(Premise) :-
	write(' '),
	write(Premise),
	nl.
% write_proof premise - prints proof, using ingents to show the tree's structure
write_proof((Goal, CF :- given), Level) :-
	indent(Level),
	write(Goal),
	write(' CF= '),
	write(CF),
	write(' given by the user'),
	nl,
	!.
write_proof((Goal, CF :- fact), Level) :-
	indent(Level),
	write(Goal),
	write(' CF= '),
	write(CF),
	write(' was a fact of knowledge base'),
	nl,
	!.
write_proof((Goal, CF :- Proof), Level) :-
	indent(Level),
	write(Goal),
	write(' CF= '),
	write(CF),
	write(' :-'),
	nl,
	New_level is Level + 1,
	write_proof(Proof, New_level),
	!.
write_proof(not(Proof), Level) :-
	indent(Level),
	write(not),
	nl,
	New_level is Level + 1,
	write_proof(Proof, New_level),
	!.
write_proof((Proof_1, Proof_2), Level) :-
	write_proof(Proof_1, Level),
	write_proof(Proof_2, Level),
	!.
indent(0).
indent(L) :-
	write(' '),
	L_new is L - 1,
	indent(L_new).
