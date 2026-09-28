% Lab 2: distance-k domination with linear models
% Run with, for example:
%   minizinc --solver coin-bc distance-domination-linear.mzn instances/grid-10x10-k2.dzn

int: n;                      % number of vertices
int: m;                      % number of edges
int: k;                      % distance over which vertices dominate

array[1..m] of int: from;    % one end of each edge
array[1..m] of int: to;      % the other end of each edge

% The neighbourhood of each vertex, computed from the edge list. This is a
% parameter: MiniZinc evaluates it before solving, so it adds no variables.
array[1..n] of set of int: nbr =
  [ {to[e] | e in 1..m where from[e] = v} union {from[e] | e in 1..m where to[e] = v}
  | v in 1..n ];

% Decision variable: 1 if vertex i is in the dominating set, 0 otherwise
array[1..n] of var 0..1: decision;

% Part B: complete this function so that ball(v, r) is the set of vertices
% at distance at most r from v. It should be recursive in r.
% function set of int: ball(int: v, int: r) = ...;

% Add your constraints and solve item below. Every constraint should be a
% linear equation or inequality over 0-1 variables.
