Acyclic Path Program - accepts a graph, a start node, and an end node from the user, then displays one or more acyclic paths, if present given the parameters.

Usage Instructions (examples use SWI-Prolog):

1. Start Prolog in the directory in which the program resides.
2. At the prompt, enter 'start.':
?- start.
3. Enter the graph used to search for an acyclic path, as prompted by the program (formatting necessary):
- Please enter the graph yoiu would like searched: graph([a,b,c,d],  [c(a,b),c(b,c),c(b,d),c(c,d),c(d,b)]).
4. Enter the path start node, as prompted by the program:
- a.
5. Enter the path end node, as prompted by the program:
- d.
6. The program will display an acyclic path if found.
- Path is [a, b, c, d]
7. (Optional) Display additional paths present by entering ';':
- true ;
- Path is [a, b, d]
- true ;
- false.
