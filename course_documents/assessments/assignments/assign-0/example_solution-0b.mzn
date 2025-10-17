int: n;                     % number of vertices
int: m;                     % number of edges

array[1..m] of int: from;    % edge start vertices
array[1..m] of int: to;      % edge end vertices

% Decision variable: 1 if vertex i is in the dominating set
array[1..n] of var 0..1: decision;

constraint forall (v in 1..n)
    (decision[v] + 
    sum(e in 1..m where from[e] = v)(decision[to[e]]) +
    sum(e in 1..m where to[e] = v)(decision[from[e]]) 
    >= 1);
    
solve minimize sum(decision)
% sum(v in 1..n)(decision[v])
