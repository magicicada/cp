% Lab 1, simple solution C: as solution B, but every constraint is a sum.
% reached[d, v] can only be 1 if at least one way of reaching v is 1.

int: n;                      % number of vertices
int: m;                      % number of edges
int: k;                      % distance over which vertices dominate

array[1..m] of int: from;    % one end of each edge
array[1..m] of int: to;      % the other end of each edge

% Decision variable: 1 if vertex i is in the dominating set, 0 otherwise
array[1..n] of var 0..1: decision;

array[0..k, 1..n] of var 0..1: reached;

constraint forall(v in 1..n)(reached[0, v] = decision[v]);

constraint forall(d in 1..k, v in 1..n)(
  reached[d, v] <= reached[d-1, v]
                   + sum(e in 1..m where from[e] = v)(reached[d-1, to[e]])
                   + sum(e in 1..m where to[e] = v)(reached[d-1, from[e]])
);

constraint forall(v in 1..n)(reached[k, v] = 1);

solve minimize sum(decision);
