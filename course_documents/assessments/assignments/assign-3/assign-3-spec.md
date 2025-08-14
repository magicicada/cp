Assignment 2: MiniZinc and ILP models of graph burning

Worth 10% of course grade

Automatically marked

Be sure to carefully follow the specification, as this code is being automatically marked!
I will be marking this on an stlinux node: be sure that your code will run there using the instructions below. This includes using only solvers that are installed on the node. 

Task: 

You will write both 
1) a MiniZinc model and 
2) an ILP model using ORTools in Python 
to compute the burning number of a graph.  

The graph burning problem (as we discuss in class) asks how quickly a fire-lighter can burn a graph.  At turn zero, the graph is unburnt.  At every turn t >= 1, to things occur:
- first, all vertices adjacent to a burning vertex burn
- the fire-lighter chooses a vertex to burn.  

The minimum number of turns that it takes to burn the entire graph is the burning number of the graph, and a sequence of vertex choices to burn is a burning sequence.  You will compute the burning number of a graph and give a burning sequence.  In this assignment we will consider both correctness and efficiency.  Students can achieve up to a B by correctly solving smaller instances, and an A by additionally correctly solving larger instances (this will require advanced model development for faster solving). 

There will additionally be a viva on the topic of this assignment and the related papers that we discuss in class.  The viva specification is available separately.  

Input formats will follow those in previous assignments.  Details to follow.  



