Minimum Path Program - accepts a start node, and an end node from the user, then displays the minimum-cost path found given these parameters and a graph hard-coded into the program.

Details of the directed, hard-coded graph (start node, end node, cost):

- edge(a, b, 3).
- edge(b, c, 1).
- edge(b, d, 5).
- edge(c, d, 2).
- edge(d, b, 2).

Usage Instructions (examples use SWI-Prolog):

1. Start Prolog in the directory in which the program resides.
2. At the prompt, enter 'start.': ?- start.
3. Enter the path start node, as prompted by the program:
- Please enter the start node for the desired path: a.
4. Enter the path end node, as prompted by the program:
- Please enter the end node for the desired path: d.
5. The program will display the minimum path found, with cost, given the parameters.
- the minimum path between a and d is [a,b,c,d] with cost = 6
