% How would we adapt to dealing with distances?

% Some ideas:
% - for a small distance, you could hard-code it
% You could look at the global constraints provided by MiniZinc
% You could have an accessory array that captures at what distance each vertex is reached by each other vertex
% This is difficult!  There will be part marks for doing a fixed-distance version, and I would expect not all students will manage to model this

Idea:
given a set of dominators:
reaches[v, s] is 1 if those dominators reach v by distance s, 0 othewise


e.g:

array[(1..n, 1..n)] of 0..1: dist_reached;

% need to enforce reaching distances with a constraint
when should dist_reached[vertex, 1] be 1?
- vertex is adjacent to something in decision
when should it be dist_reached[vertex, 2] be 1?
 - if it was reached at 1 dist_reached[vertex, 1] be 1
 - if dist_reached[other_vertex, 1] is 1 AND vertex is adjacent to other_vertex
 
when should dist_reached[vertex, 3] be 1?
- when dist_reached[vertex, 2] is 1
- when one of its neighbours was reached at distance 2

