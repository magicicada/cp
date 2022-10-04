# Week 3 - 5 October 2022

## :clipboard: Admin :clipboard:
- Quiz 1 now available on Moodle - due Friday
- Quiz 2 will be next week
- Assignment 1 now up, due on the 11th - should not take you a full week!
- This afternoon's session: bring any questions about the assignment, otherwise more MiniZinc examples
- Working to get you the spec for poster ASAP
- We have exceeded room capacity for our original room.  
    - We are in Boyd Orr this morning
    - Adam Smith 916 next Wednesday morning
    - Rankine Building in afternoons
    - May need to split you into quarters and request one-quarter view recording once we're back in small room.  
    - **Keep an eye on your timetable, we may move rooms at short notice**
 

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

> <insert hand-drawn example>

Why do we need to do anything else?
- this search will often be too slow. 

There are many approaches to help us go faster!
- successor ordering
- arc consistency ⬅
- fancier consistencies

# Arc consistency (AC)
The idea of arc consistency is to decrease the size of the domains before we start searching - sometimes we even get lucky and solve the problem without any search.  

## Constraint networks 
We can 

## Algorithm for AC

### Examples

### Time complexity

