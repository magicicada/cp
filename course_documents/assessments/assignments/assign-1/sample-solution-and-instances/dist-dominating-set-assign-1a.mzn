int: n;                     % number of vertices
int: m;                     % number of edges
int: k;                     % distance for domination

array[1..m] of int: from;    % edge start vertices
array[1..m] of int: to;      % edge end vertices

% Decision variable: 1 if vertex i is in the dominating set
array[1..n] of var 0..1: decision;

array[0..k, 1..n] of var bool: reach;
%array[(1..n, 1..n)] of 0..1: dist_reached;

%base
constraint forall(v in 1..n)( reach[0,v] <-> (decision[v] = 1));

%grow reachability one step at a time
constraint forall(t in 0..k-1, v in 1..n)(
  reach[t+1,v] <-> (reach[t,v] \/ exists(u in 1..n)(reach[t,u] /\ exists(e in 1..m)((from[e] = u /\ to[e] = v) \/(from[e] = v /\ to[e] = u))))
);

%dominate by distance k, every vertex must be reached
constraint forall(v in 1..n)(reach[k,v]);

solve minimize sum(u in 1..n)(decision[u]);