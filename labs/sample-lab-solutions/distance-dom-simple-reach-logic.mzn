% Lab 1, simple solution B: general k, with a 0-1 table of reached vertices.
% reached[d, v] = 1 means v is within distance d of a chosen vertex.

int: n;                      % number of vertices
int: m;                      % number of edges
int: k;                      % distance over which vertices dominate

array[1..m] of int: from;    % one end of each edge
array[1..m] of int: to;      % the other end of each edge

% Decision variable: 1 if vertex i is in the dominating set, 0 otherwise
array[1..n] of var 0..1: decision;

array[0..k, 1..n] of var 0..1: reached;

% distance 0: only the chosen vertices themselves are reached
constraint forall(v in 1..n)(reached[0, v] = decision[v]);

% distance d: v can only be reached at distance d if it was reached at
% distance d-1, or one of its neighbours was
constraint forall(d in 1..k, v in 1..n)(
  reached[d, v] = 1 ->
    ( reached[d-1, v] = 1
      \/ exists(e in 1..m where from[e] = v)(reached[d-1, to[e]] = 1)
      \/ exists(e in 1..m where to[e] = v)(reached[d-1, from[e]] = 1) )
);

% every vertex must be reached within distance k
constraint forall(v in 1..n)(reached[k, v] = 1);

solve minimize sum(decision);
