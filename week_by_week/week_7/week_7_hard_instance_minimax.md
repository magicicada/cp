---
tags: cp, cp_2022, teaching
---
# Week 6 - Hard instances and Game search
:clipboard:Admin :clipboard:
- quiz this week covering last two weeks
- this afternoon: Q&A/Office hours style 
- next week Ciaran starts his 2 weeks of lecture


# Hard Instances
(note: I do *not* expect you to reflect this lecture in your assignment 2 submission - that would not be fair!)

Reminder: what does it mean for a problem to be NP-hard?

- First: it *doesn't* mean that every instance of that problem is hard to solve.  
- (Informally) it means that we can take any instance of any other problem in NP and encode it as an instance of our problem.

Let's talk about graph colouring:
- 3-colouring is NP-complete
    - (graph colouring is NP-hard)
- We can take any instance of any problem in NP and make it into a 3-colouring instance such that the yes/no answer stays the same.  

But, as we've touched on briefly, this doesn't mean that every instance is hard!

> <we'll do a few live examples>

There are some important ideas here, including the notions of being 
- underconstrained
- overconstrained

What do these notions look like in a search tree?


> <live examples>


## Phase transitions in various problems
    
If we have an idea of a characteristic of instances that move them from under to over constrained, we might plot runtime of our solver as a function of that parameter.  We sometimes see what is called a *phase transition* when we do this.  it usually looks something like this:
    
> <insert image>
    
We'll look at some examples as we go along.  
    
Side note: the phrase *phase transition* is from chemistry/physics - as in the transition from liquid to solid.
    
Example from an (older) paper on colouring at https://www.sciencedirect.com/science/article/pii/0004370295000445
    ![](https://i.imgur.com/rishTgw.png)

Or even more vintage:
    https://www.dcs.gla.ac.uk/~pat/cpM/papers/cheeseman91where.pdf
    
    
(we'll have a quick look but not too much detail as it's one of the suggested poster papers)
    
SAT has them as well:
https://www.cse.unsw.edu.au/~tw/ECAI94.pdf
    
# Game search
This is squarely in the 'other solvers' category, but I've had a few requests.  
    
What do we mean by game search?
    
> <tic-tac-toe example>
    
**Minimax** is the basic game search.  The name comes from finding the *min* of the *max*.

(courtesy of wikipedia, some pseudocode)
```
function  minimax( node, depth, maximizingPlayer ) is
    if depth = 0 or node is a terminal node then
        return the heuristic value of node
    if maximizingPlayer then
        value := −∞
        for each child of node do
            value := max( value, minimax( child, depth − 1, FALSE ) )
        return value
    else (* minimizing player *)
        value := +∞
        for each child of node do
            value := min( value, minimax( child, depth − 1, TRUE ) )
        return value
(* Initial call *)
minimax( origin, depth, TRUE )
```
    
(also from wikipedia, an example tree for a 2-player 2-option game with example leaf values)
    
![](https://i.imgur.com/sIxIbQq.png)

    
Let's construct this tree with values for our tic-tac-toe example.  
    
What does this tell us about games?  How canwe interpret the value at the root?
    
## How can we make this faster?
Without improvements, minimax will construct the entire game tree.
    
We can deploy many tricks!
- alpha-beta pruning
- hash tables for repeat states
- node ordering (maybe find a win faster)
- trickery to make at-node computation faster
- if we're not likely to solve exactly can use node value heuristics
    
Two now-old things that were exciting at the time:
- Alpha-Go https://en.wikipedia.org/wiki/AlphaGo, via
- Monte Carlo Tree Search
    
    ![](https://i.imgur.com/Ox1IcMq.png)
