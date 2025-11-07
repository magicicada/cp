Assignment 3a: MiniZinc and ILP models of graph burning
- Due Monday 24th November 4:30 pm
- Worth 10% of course grade
- Automatically marked
- **upload exactly one .mzn file called graph-burning-assign-3.mzn and one .py file called submitted_graph_burning_solution.py to Moodle and nothing else**

Be sure to carefully follow the specification, as this code is being automatically marked.
I will be marking this on an stlinux node: be sure that your code will run there using the instructions below. This includes using only solvers that are installed on the node. 

Task: 

You will write both 
1) a MiniZinc model and 
2) an ILP model using ORTools in Python 
to compute the burning number of a graph.  

The graph burning problem (as we discuss in class) asks how quickly a fire-lighter can burn a graph.  At turn zero, the graph is unburnt.  At every turn t >= 1, two things occur:
- first, all vertices adjacent to a burning vertex burn
- the fire-lighter chooses a vertex to actively burn.  

The minimum number of turns that it takes to burn the entire graph is the burning number of the graph, and a sequence of vertex choices to burn is a burning sequence.  You will compute the burning number of a graph and give a burning sequence.  In this assignment we will consider both correctness and efficiency.  Students can achieve up to a B by correctly solving smaller instances, and an A by additionally correctly solving larger instances (this will require advanced model development for faster solving). 

There will additionally be a viva on the topic of this assignment and the related papers that we discuss in class.  The viva specification is available separately.  

Input formats will follow those in previous assignments: that is, 
- for the MiniZinc model the graphs will be specified in a .dzn file as in Assignment 0
- for the ORTools model the graphs will be passed to your code as a networkx object

As a reminder, the .dzn file format looks like:

```
n = 5;
m = 6;
from = [1,1,2,3,3,4];
to = [2,4,3,4,5,5];
```


where 
- n is the number of vertices
- m is the number of edges
- from lists one end of each edge
- to lists the other end of each edge 

That is, the graph as specified in the example has five vertices, and the edge set is {(1,2), (1, 4), (2, 3), (3, 4), (3, 5), (4, 5)}.  The graph is undirected.


I have provided a stub for both pieces of code.  In general, these follow the pattern of the stubs for the two previous assignments, and we will also discuss these in lecture, bring any questions to lecture on Wednesday, November 12th.  I will update this file with FAQs after that. 



