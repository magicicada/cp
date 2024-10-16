# Week 3 

# Search and Arc Consistency

Recall: we're dealing with CSPs, which consist of
- a set of variables, each of which has a
-  domain of possible values, and 
-  a set of constraints that an acceptable solution must meet

Let's denote these as triples $(X, D, C)$ where: $X$ is a set of variables, $D$ is a set of domains for the variables, $C$ are constraints 

## Search revisited

We talked a bit about using search to solve CSPs.  Let's review a bit, and then expand more formally on **backtracking search** which we saw the seeds of before as *combinatorial search*.

### Reminder: generate-and-test
Intuition: we generate every possible solution within the join domains of the variables and test to see if each is a solution.

For simplicity today we're going to use a small arithmetic example CSPs:
- $X = \{a, b, c\}$
- $D(a) = D(b) = D(c) = {1, 2, 3}$
- $C = \{C_1, C_2\}$
    - $C_1 = a < b$
    - $C_2 = b < c$

How might we generate all solutions?  If we want to hard-code for this problem, then something like:

```
for value_a in D(a):
    for value_b in D(b):
        for value_c in D(c):
            if value_a < value_b and value b < value_c:
                return value_a, value_b, value_c
return UNSAT
```

Not great.  In the worst case this will be a large number of checks, and is inelegant to implement.  For a larger problem will be far too many checks to be feasible.

### Revisit: backtrack search

We saw a better (but still asymptotically exponential time) search in week 1 as 'combinatorial search' - here we'll look at this a little more formally and include a little more pruning and call it **backtrack search**

The idea here is to search the space via depth-first search, but give up on a branch (and 'prune' it and 'backtrack') when we know it can't be part of any solution.  
- One time when we know it can't be part of any solution: when we have fixed all the variable involved in some constraint, and that constraint isn't satisfied.

Example on our example CSP: a partial solution that has $a = 2$ and $b = 1$ can't be part of any solution and can be pruned.  

> <hand-drawn example in lecture>

Why do we need to do anything else?
- this search will often be too slow. 

There are many approaches to help us go faster!
- successor ordering
- arc consistency ⬅
- fancier consistencies

# Arc consistency (AC)
The idea of arc consistency is to decrease the size of the domains before we start searching - sometimes we even get lucky and solve the problem without any search.  

## Constraint networks 
We can represent the relationships between variables and constraints as a (bipartite) graph, and then we will examine each edge (or *arc*) to compute arc consistency

In our **constraint network**
- each variable is a node (conventionally a circle)
- each constraint is a node (conventionally a rectangle)
- edge between a variable node and a constraint node when that variable is involved in that constraint

> <hand-drawn example in lecture>
    
Then we way that an arc between a variable $X$ and a binary constraint $C_i(x, y)$ is **arc consistent** if for each value in the domain of $x$ there is a value in the domain of $y$ that satisfies $C_i$.
    
We'll look at our example for arcs where that might not be true for our full domains.  
    
We say our whole CSP is arc consistent if every arc is.
    
So what do we do if our CSP is not arc consistent?
- we can make our CSP arc consistent!
- remove every value from a domain that is not consistent.
    - but then we might need to adjust other domains as we might have made other arcs inconsistent.  
    
Which arcs do we need to reconsider?  Not all of them!
- if we remove a value from the domain of variable $X$, we need only reconsider arcs from other variables to constraints that also involve $X$.
    
To think about: why do we not yet need to consider other arcs from $X$ to other constraints?

> <hand-drawn example in lecture>
    
## Algorithm for AC

We can now write out an algorithm for enforcing arc consistency:

```
function ac(X, D, C):
    **Takes** variables X, domains D, constraints C
    **Gives** arc consistent domains for variables
    set D_new gets empty set
    set todo gets empty set
    for each variable x in X:
        D_new[x] gets D[x]
        todo gets all arcs from x to a constraint involving x
    while todo is not empty:
        get an arc (x, c) from todo
        remove (x, c) from todo
        y is the other variable involved in c
        domain_changed gets False
        for every value_x in D_new[x]:
            remove_me gets True
            for value_y in D_new[y]:
                if value_x, value_y satisfy c:
                    remove_me gets False
                    stop loop
            if remove_me:
                remove value_x from D_new[x]
                domain_changed gets True
        if domain_changed:
            add all arcs from other variables to constraints involving x to todo        
```

There are three possible outcomes after we run this algorithm:
1. Every domain has only one value
2. At least one domain has no values
3. All domains have at least one value, some have more
    
What do these mean?

A few time complexity questions to ponder as we look at examples:
- why will this halt?
- how long will this take?
    
### Examples
    
A formal working of our on-going simple integer example
    
Another simple integer example
    
A graph colouring example
    

### Time complexity

So why will AC halt?
- in short, because we cannot remove things from domains indefinitely.  Informally:
    - if we ever do an iteration with no removals and todo is empty then we stop
    - Every time we remove something a domain gets smaller: eventually we end up with empty domains.
    
Or, thought about another way: every iteration either removes something from a domain or doesn't add anything to todo.  Therefore there are a finite bounded number of times we add things to todo, because the sum of the domains is finite.
    
Then what is the worst-case time complexity? on a problem with $n$ variables, $d$ maximum domain size, $c$ number of constraints.
- when we check our domains for consistency, this takes $O(d^2)$
- how many things will we add to our todo queue? consider from a degree perspective: $O(cd)$
- so $O(cd^3)$
