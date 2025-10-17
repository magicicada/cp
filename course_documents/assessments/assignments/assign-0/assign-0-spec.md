Assignment 0: Dominating Set MiniZinc Model
Worth 0% of course grade
Automatically marked
** upload exactly one .mzn file called dominating-set-assign-0.mzn to Moodle and nothing else **

Be sure to carefully follow the specification, as this code is being automatically marked!
I will be marking this on an stlinux node: be sure that your code will run there using the instructions below.

Task: 

You will write a MiniZinc model to compute a minimum dominating set on an input graph.
This is a formative assignment, and is worth no marks, but will give you an opportunity to make sure that you can write and run models in a way consistent with the automated marking, and help you in your summative assignments. 

Dominating Set:

Given a graph G = (V, E) a *dominating set* S is a subset of V such that every vertex in V is either in S or is adjacent to a vertex in S. A minimum dominating set is a smallest dominating set. 

You will take an input graph as a .dzn file (example in `sample-input-file-0.dzn`) that contains:

(values are examples)

n = 5;
m = 6;
from = [1,1,2,3,3,4];
to = [2,4,3,4,5,5];

where 
- n is the number of vertices
- m is the number of edges
- from lists one end of each edge
- to lists the other end of each edge 

That is, the graph as specified in the example has five vertices, and the edge set is {(1,2), (1, 4), (2, 3), (3, 4), (3, 5), (4, 5)}.  The graph is undirected.

You should design your model so that the solution is recorded in a 0-1 array called `decision` such that the ith entry in decision is 1 if vertex i is in the dominating set.  You can achieve this by starting with the startup dominating-set-assign-0.mzn file and adding your model to it.  



How I will run your code:

I will run your assignment submission by running the following from the command line:
`minizinc dominating-set-assign-0.mzn sample-input-file-0.dzn`

From which I would expect:

``
decision = [1, 0, 0, 0, 1];
----------
==========
``
Do not amend your output.  I will pipe this output to a python file that checks whether the output is a dominating set on the input graph. 

For example, I will mark with:

`minizinc dominating-set-assign-0.mzn sample-input-file-0.dzn > output.txt`
`python dom-set-marking.py sample-input-file-0.dzn output.txt`

Which should for that input give me 
`true,2`
 indicating that the solution the model found is a dominating set (the 'true') and that it is of size 2. For the future assignments I would then use that for determining a grade. 


I will use several different input files, all with the same format as `sample-input-file-0.dzn`
For an example input file, look at `sample-input-file-0.dzn`, provided alongside this assignment spec.  We will discuss this format in class, bring any questions.  


