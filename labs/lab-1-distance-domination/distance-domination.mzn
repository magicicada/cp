% Lab 1: minimum distance-k dominating set
% Run with:  minizinc distance-domination.mzn instances/small-5-k2.dzn

int: n;                      % number of vertices
int: m;                      % number of edges
int: k;                      % distance over which vertices dominate

array[1..m] of int: from;    % one end of each edge
array[1..m] of int: to;      % the other end of each edge

% Decision variable: 1 if vertex i is in the dominating set, 0 otherwise
array[1..n] of var 0..1: decision;

% You may add further decision variables, but do not rename or remove `decision`.

% Add your constraints and solve item below.
