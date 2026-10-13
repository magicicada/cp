% Lab 0 reference solution: minimum dominating set

int: n;                      % number of vertices
int: m;                      % number of edges

array[1..m] of int: from;    % one end of each edge
array[1..m] of int: to;      % the other end of each edge

% Decision variable: 1 if vertex i is in the dominating set, 0 otherwise
array[1..n] of var 0..1: decision;

% every vertex is chosen or has a chosen neighbour
constraint forall(v in 1..n)(
  decision[v]
  + sum(e in 1..m where from[e] = v)(decision[to[e]])
  + sum(e in 1..m where to[e] = v)(decision[from[e]]) >= 1
);

solve minimize sum(decision);
