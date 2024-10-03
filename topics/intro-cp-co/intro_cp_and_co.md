# Intro to CP and Combinatorial Optimisation
## Aims:
- introduce/remind what a combinatorial optimisation problem is
    - similarly decision problem
- mention types of solvers
- introduce idea of a CP
- start modelling with MiniZinc

## Resources:

Other people's intros:
- https://www.cs.upc.edu/~erodri/webpage/cps/theory/cp/intro/slides.pdf
- https://ktiml.mff.cuni.cz/~bartak/constraints/intro.html
- Peter Stuckey's course: https://www.coursera.org/lecture/basic-modeling/1-1-1-first-steps-PYg0S (and the stuff after that)

# Notes:
## What do we mean by combinatorial optimisation?
- we're looking at discrete problems here - no real numbers
- you've seen lots of these before in CS, and we'll look at some examples
- optimisation finds a solution that optimises some characteristic
    - e.g. the biggest clique, the fastest schedule, etc.
- decision asks if it can be done (e.g. can we colour a graph with three colours)
    - decision versions are important from a complexity perspective: recall NP-completeness notions 

### Example problem: Max Clique
- given a graph $G = V, E$ and an integer $k$: is there a clique of at least size $k$ in $G$?
    - a clique is a set of vertices that are all pariwise adjacent
- or, in the optimisation version: what is the size of the largest clique?
- (planned live example)

### Example problem: Graph 3-colouring
- given a graph $G = (V, E)$ can we assign colours to the vertices of the graph so that no two adjacent vertices have the same colour?
- (planned live example)

### Example problem: Satisfiability (particularly 3-CNF SAT)
- this one is a bit special from a complexity perspective
- 3-CNF-SAT is conjunctive normal form satisfiability in which all clauses have three literals
- Given a formula $F$ in propositional logic, is $F$ satisfiable?
    - is there a truth value assignment to the variables mentioned in $F$ such that $F$ is overall True?
- (planned live example)


## Example solver types:
There are many types of general solver for these types of problems, and often these go along with expressing the problem in particular ways.  We'll touch on some of these throughout the course, and I'll mention a few now:
- CP solvers based on search
- SAT solvers
- IP solvers
- SIMPLEX
- Not-guaranteed-to-be-optimal heuristic solvers

### Example solver approach: (Exhaustive) Combinatorial search
To get started with search-based spproaches, let's talk about a naive approach to combinatorial search
- we'll do it via an example of max clique
- we'll draw a search tree
- (planned live example)

## But isn't this course about constraint programming?
Ok, fine.  Enough solving for now, let's talk CP.  

A \emph{constraint program} is a framework for solving \emph{constraing satisfaction problems} (CSP).  

A CSP is a triple consisting of:
- variables
- domains for the variables
- constraints
Often we'd denote these $(X, D, C)$ where $X$ is a set of variables, $D$ is a set of domains for the variables, $C$ are constraints 

### Example: Graph colouring on graph $G = (V, E)$:
- Variables: $\{c_v |  v \in V\}$ - colour for each vertex
- Domains: $\{1, 2, ... k\}$ - all the colours
- Constraints: when $(u, v) \in E$ then $c_u \neq c_v$

(planned live example)

### Example: Satisfiability on formula $F$:
- Variables: all the variables in the formula
- Domains: \{True, False\} for all variables
- Constraints: the entire formula $F$

(planned live example)

### More formally, what are constraints?
One way to formally view a **constraint** is as a pair $C = (S, R)$ where $S = (x_{i_1}, ... x_{i_k})$ are the variables the constraint is about (the scope), and $R$ are the tuples that satisfy the constraint - note that therefore 
$R \subseteq d_{i_1} \times ... \times d_{i_k}$ where $d_{i_j}$ is the domain of $x_{i_j}$.  

But for many kinds of constraints this would be an unacceptably cumbersome set, and so we often specify constraints in more compact ways, e.g. those above for colouring, SAT. 

### Before we continue, a note about solution concepts
We are sometimes interested in different notions of *solution*.  We'll touch on these as we go and have already brushed up against them, but for now note that sometimes we want:
- all solutions
- a single solution (decision?)
- the cheapest solution (optmisation?)

## MiniZinc
 MiniZinc is a modelling language for CSPs that conveniently comes with hooks into various solvers.  We are using MiniZinc so that we can get up and constraint programming as quickly as possible.  
 
We'll start working through a MiniZinc tutorial and then work on some examples:
http://www.dcs.gla.ac.uk/~pat/cpM/minizincCPM/tutorial/minizinc-tute.pdf
or here: https://www.minizinc.org/doc-2.5.5/en/modelling.html
I sometimes like to run MiniZinc from Python: https://minizinc-python.readthedocs.io/en/latest/getting_started.html





