% Lab 0: minimum dominating set
% Run with:  minizinc dominating-set.mzn instances/small-5.dzn

int: n;                      % number of vertices
int: m;                      % number of edges

array[1..m] of int: from;    % one end of each edge
array[1..m] of int: to;      % the other end of each edge

% Decision variable: 1 if vertex i is in the dominating set, 0 otherwise
array[1..n] of var 0..1: decision;

% Add your constraints and solve item below.
