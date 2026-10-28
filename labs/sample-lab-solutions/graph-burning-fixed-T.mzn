% Lab 3 reference solution, Task 2: can G be burned in exactly T turns?
% Run with, for example:  minizinc graph-burning-fixed-T.mzn path-9.dzn -D "T=3"

int: n;                      % number of vertices
int: m;                      % number of edges

array[1..m] of int: from;    % one end of each edge
array[1..m] of int: to;      % the other end of each edge

array[1..n] of set of int: nbr =
  [ {to[e] | e in 1..m where from[e] = v} union {from[e] | e in 1..m where to[e] = v}
  | v in 1..n ];

int: T;

array[1..n] of var 0..T: burn_turn;
var 1..n: turns = T;

% burnt[t, v]: v is burning at the end of turn t
array[0..T, 1..n] of var bool: burnt;

% exactly one vertex is chosen at each turn
constraint forall(t in 1..T)(sum(v in 1..n)(burn_turn[v] = t) = 1);

constraint forall(v in 1..n)(not burnt[0, v]);

% spread from burning neighbours, then the chosen vertex
constraint forall(t in 1..T, v in 1..n)(
  burnt[t, v] <-> (burnt[t-1, v] \/ exists(u in nbr[v])(burnt[t-1, u]) \/ burn_turn[v] = t)
);

constraint forall(v in 1..n)(burnt[T, v]);

solve satisfy;

output ["turns = \(turns);\n",
        "sequence = \([v | t in 1..fix(turns), v in 1..n where fix(burn_turn[v]) = t]);\n"];
