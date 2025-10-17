% This doesn't quite do what we want
int: n; 
int: m;                     % number of edges

array[1..m] of int: from;    % edge start vertices
array[1..m] of int: to;      % edge end vertices

% Decision variable: 1 if vertex i is in the dominating set
array[1..n] of var 0..1: decision;

constraint forall(e in 1..m)(
    decision[from[e]] == 1 \/
    decision[to[e]] == 1
  );

solve minimize sum(decision)