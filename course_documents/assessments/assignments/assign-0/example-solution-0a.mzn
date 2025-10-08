
int: n;                     % number of vertices
int: m;                     % number of edges

array[1..m] of int: from;    % edge start vertices
array[1..m] of int: to;      % edge end vertices

% Decision variable: 1 if vertex i is in the dominating set
array[1..n] of var 0..1: decision;

% Function to get neighbors of a vertex v from edge list
function set of int: neighbors(int: v) =
    { to[e]   | e in 1..m where from[e] = v } union
    { from[e] | e in 1..m where to[e]   = v };

% Constraint: every vertex must be dominated by itself or a neighbor
constraint
    forall(v in 1..n) (
        decision[v] + sum(u in neighbors(v))(decision[u]) >= 1
    );

% Objective: minimize the number of chosen vertices
solve minimize sum(i in 1..n)(decision[i]);

