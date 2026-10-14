% Lab 1 reference solution: minimum distance-k dominating set, general k

int: n;                      % number of vertices
int: m;                      % number of edges
int: k;                      % distance over which vertices dominate

array[1..m] of int: from;    % one end of each edge
array[1..m] of int: to;      % the other end of each edge

% Decision variable: 1 if vertex i is in the dominating set, 0 otherwise
array[1..n] of var 0..1: decision;

array[1..n] of set of int: nbr =
  [ {to[e] | e in 1..m where from[e] = v} union {from[e] | e in 1..m where to[e] = v}
  | v in 1..n ];

% reach[t, v]: v is within distance t of some chosen vertex
array[0..k, 1..n] of var bool: reach;

constraint forall(v in 1..n)(reach[0, v] <-> decision[v] = 1);

constraint forall(t in 1..k, v in 1..n)(
  reach[t, v] <-> (reach[t-1, v] \/ exists(u in nbr[v])(reach[t-1, u]))
);

constraint forall(v in 1..n)(reach[k, v]);

solve minimize sum(decision);
