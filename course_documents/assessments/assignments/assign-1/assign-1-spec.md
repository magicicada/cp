Assignment 1: MiniZinc model of variable-distance dominating set
- Due Monday, 20 October 2025, 4:30 PM (UK time)
- Worth 5% of course grade
- Automatically marked
- **upload exactly one .mzn file to Moodle and nothing else**


Be sure to carefully follow the specification, as this code is being automatically marked!
I will be marking this on an stlinux node: be sure that your code will run there using the instructions below.

Task: 

You will write a MiniZinc model to compute a minimum distance dominating set on an input graph.

Distance dominating Set:

Given a graph G = (V, E) a *distance k dominating set* S is a subset of V such that every vertex in V is either in S or is within distance k (counting edges) to a vertex in S. A minimum distance k dominating set is a smallest such set.

Note that if k is 1, then this is the same as dominating set.  If k is zero, we would expect all vertices to dominate only themselves. 

You will take an input graph as a .dzn file (example in `sample-input-file-1.dzn`) that contains:

(values are examples)

```
n = 5;
m = 6;
k = 2
from = [1,1,2,3,3,4];
to = [2,4,3,4,5,5];
```

where 
- n is the number of vertices
- m is the number of edges
- k is the distance over which vertices dominate
- from lists one end of each edge
- to lists the other end of each edge 

That is, the graph as specified in the example has five vertices, and the edge set is {(1,2), (1, 4), (2, 3), (3, 4), (3, 5), (4, 5)}.  The graph is undirected.

You should design your model so that the solution is recorded in a 0-1 array called `decision` such that the ith entry in decision is 1 if vertex i is in the distance dominating set.  You can achieve this by starting with the startup dist-dominating-set-assign-1.mzn file and adding your model to it.  



How I will run your code:

I will run your assignment submission by running the following from the command line:
`minizinc dist-dominating-set-assign-1.mzn sample-input-file-1.dzn`

From which I would expect (for example):

```
decision = [1, 0, 0, 0, 0];
----------
==========
```

Do not amend your output.  I will pipe this output to a python file that checks whether the output is a dominating set on the input graph. 

For example, I will mark with:

```
minizinc dist-dominating-set-assign-1.mzn sample-input-file-1.dzn > output.txt
python3 dist-dom-set-marking.py sample-input-file-1.dzn output.txt
```

Which should for that input give me 
`true,1`
 indicating that the solution the model found is a k distance dominating set (the 'true') and that it is of size 1. I would then use that for determining a grade, based on the number of instances that your model solves correctly and whether they are correct in both being a distance dominating set and in being minimal. 


I will use several different input files, all with the same format as `sample-input-file-1.dzn`
For an example input file, look at `sample-input-file-1.dzn`, provided alongside this assignment spec.  We will discuss this format in class, bring any questions.  




