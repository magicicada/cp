
# Hard Instances

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
    
