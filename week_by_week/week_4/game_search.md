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
    
What does this tell us about games?  How can we interpret the value at the root?
    
## How can we make this faster?
Without improvements, minimax will construct the entire game tree.
    
We can deploy many tricks!
- negamax (not a sci-fi robot: https://en.wikipedia.org/wiki/Negamax)
- alpha-beta pruning (https://en.wikipedia.org/wiki/Alpha%E2%80%93beta_pruning)
- hash tables for repeat states (https://en.wikipedia.org/wiki/Transposition_table)
- node ordering (maybe find a win faster)
- trickery to make at-node computation faster
- if we're not likely to solve exactly can use node value heuristics
    
Two now-old things that were exciting at the time:
- Alpha-Go https://en.wikipedia.org/wiki/AlphaGo, via
- Monte Carlo Tree Search
    
    ![](https://i.imgur.com/Ox1IcMq.png)
    
   
## Shall we implement?