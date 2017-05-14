% Simple example program demonstrating
% accepting user input, some basic 
% operations, and using functions.
% ------------------------------------

start :-
		write('Please enter the factorial you would like to compute: '),
		read(X),
		myfactorial(X).
myfactorial(0, 1).
myfactorial(N, Result) :-
		N > 0,
		NN is N - 1,
		myfactorial(NN, Holder),
		Result is N * Holder.
myfactorial(N) :-
		myfactorial(N, Result),
		write('The result of the computed factorial is '),
		write(Result).
