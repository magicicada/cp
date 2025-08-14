Assignment 2: ILP model of variable-distance dominating set

Worth 5% of course grade

Automatically marked

Be sure to carefully follow the specification, as this code is being automatically marked!
I will be marking this on an stlinux node: be sure that your code will run there using the instructions below. This includes using only solvers that are installed on the node. 

Task: 

You will write an ILP model using ORTools in Python model to compute a distance-k minimum dominating set on an input graph.

Distance dominating Set:

Given a graph G = (V, E) a *distance k dominating set* S is a subset of V such that every vertex in V is either in S or is within distance k (counting edges) to a vertex in S. A minimum distance k dominating set is a smallest such set.

Note that if k is 1, then this is the same as dominating set.  If k is zero, we would expect all vertices to dominate only themselves. 

You will write python code to model distance k dominating set as an ILP using ORTools. You code must take a graph specified as a `networkx` model along with an integer k and solve distance k minimum dominating set, returning a list of vertices in a minimum such set. 


I will provide starter python code that shows how I will pass an instance into your code.  


