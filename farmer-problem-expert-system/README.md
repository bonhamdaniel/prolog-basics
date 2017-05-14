Farmer Problem using an expert system - displays a solution to the farmer problem, including a proof of the solution details, using an expert system approach.

Description of the Farmer Problem:

- Consider the famous problem of a farmer having a goat, a wolf, and a cabbage. The farmer wants to cross the river from the east shore to the west shore, but his boat is small. The boat has space for only the farmer with one of the items: cabbage, wolf, or goat. The farmer cannot leave the wolf alone with the goat or the goat alone with the cabbage.
- The state space for this problem can be represented by the different situations of the four subjects that can be at any time either on the east or the west shore, but when moving from one state to another the items are subject to the conditions specified in the previous paragraph.
- We can represent a state space by the relation s(X, Y), which is true only if there is a legal move from state X to state Y within the specified conditions.
- Each state can be represented by the tuple (FP, GP, WP, CP), where the variables FP, GP, WP, CP can have only two values (e, w), which indicate the position east or west of the farmer, goat, wolf, and cabbage.
- The initial state of the system can be represented by (e, e, e, e), where all subjects are on the east side.
- The goal state of the system can be represented by (w, w, w, w), where all subjects have been moved to the west side.
- Other intermediate states will be represented using combinations of these positions (e,w).

Usage Instructions (examples use SWI-Prolog):

1. Start exshell.pl Prolog file from the directory in which it resides.
2. At the prompt, enter 'run.':
- ?- run.
3. Enter the name of the knowledge base associated with the experst system, as prompted by the program:
- Please enter the name of the file containing the knowledge base.knowledgebase.
- % knowledgebase compiled 0.00 sec, 37 clauses
- true.
4. Start interaction with the expert shell by entering 'solve(path(Path), CF).':
- ?- solve(path(Path), CF).
5. The system will respond with instructions.
- Response must be either:
- Confidence in truth of query.
- A number between -100 and 100.
- why.
- how(X), where X is a goal
-
- User query: multiple_solutions
6. Enter '-100.' to find a single solution, or '100.' for multiple solutions:
- ?-100.
- User query: start
7. Enter the certainty factor parameter you wish to provide for the solution:
- ?100.
8. The program will display the solution:
- Path = 'Solution #1: (e,e,e,e)-(w,w,e,e)-(e,w,e,e)-(w,w,e,w)-(e,e,e,w)-(w,e,w,w)-(e,e,w,w)-(w,w,w,w)',
- CF = 100
9. Enter ';' to continue interaction with the system:
- CF = 100 ;
- User query:end
10. If you would like to see a proof of the solution, enter 'how(state(goal)).':
- ?how(state(goal)).
- state(goal)concluded with certainty 100
- 
- The proof is 
- 
- state(goal) CF= 100 :-
-  goal(w,w,w,w) CF= 100 :-
-   cabbage_wolf(e,e,w,w) CF= 100 :-
-    farmer_cabbage_wolf(w,e,w,w) CF= 100 :-
-     wolf(e,e,e,w) CF= 100 :-
-      farmer_goat_wolf(w,w,e,w) CF= 100 :-
-       goat(e,w,e,e) CF= 100 :-
-        farmer_goat(w,w,e,e) CF= 100 :-
-         start(e,e,e,e) CF= 100 :-
-          start CF= 100 given by the user
- 
- User query:end
