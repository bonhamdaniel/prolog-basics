% Simple example program demonstrating
% accepting user input, basic list 
% manipulation, and using functions.
% ------------------------------------

vowel(a).
vowel(e).
vowel(i).
vowel(o).
vowel(u).
vowel(y).

consonant(L) :-
	not(vowel(L)).
  
start:-
	write('Please enter the word you would like broken up: '),
	read(Word),
	atom_chars(Word, List),
	split([ ], List),
	!.
split(Result, [ ]) :-
	write_result(Result).
split(Result, [L1, L2, L3 | Tail]) :-
	vowel(L1),
	consonant(L2),
	vowel(L3),
	split(['-', L3, L2, L1 | Result], Tail).
split(Result, [L1, L2, L3, L4 | Tail]) :-
	vowel(L1),
	consonant(L2),
	consonant(L3),
	vowel(L4),
	split([L4, L3, '-', L2, L1 | Result], Tail).
split(Result, [L1 | Tail]) :-
	split([L1 | Result], Tail).
write_result([ ]).
write_result([H | T]) :-
	write_result(T),
	write(H).
