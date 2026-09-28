% Lab 3: graph burning
% Run with:  minizinc graph-burning.mzn instances/path-9.dzn

int: n;                      % number of vertices
int: m;                      % number of edges

array[1..m] of int: from;    % one end of each edge
array[1..m] of int: to;      % the other end of each edge

% Decision variables.
% burn_turn[v] = t if vertex v is chosen for active burning at turn t,
%                0 if v is never chosen.
array[1..n] of var 0..n: burn_turn;

% The number of turns taken to burn the whole graph.
var 1..n: turns;

% You may add further decision variables, and you may narrow the domains of
% the two above, but do not rename or remove them.

% Add your constraints and solve item below.

% Prints the number of turns and the burning sequence (the vertex chosen at
% turns 1, 2, ..., turns). Do not change this.
output ["turns = \(turns);\n",
        "sequence = \([v | t in 1..fix(turns), v in 1..n where fix(burn_turn[v]) = t]);\n"];
