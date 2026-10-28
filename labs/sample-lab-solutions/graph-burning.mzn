% Lab 3 reference solution, Task 3: simulation model minimising the number of turns

int: n;                      % number of vertices
int: m;                      % number of edges

array[1..m] of int: from;    % one end of each edge
array[1..m] of int: to;      % the other end of each edge

array[1..n] of set of int: nbr =
  [ {to[e] | e in 1..m where from[e] = v} union {from[e] | e in 1..m where to[e] = v}
  | v in 1..n ];

array[1..n] of var 0..n: burn_turn;
var 1..n: turns;

% burnt[t, v]: v is burning at the end of turn t
array[0..n, 1..n] of var bool: burnt;

% exactly one vertex is chosen at each turn 1..turns, and none afterwards
constraint forall(t in 1..n)(sum(v in 1..n)(burn_turn[v] = t) = (t <= turns));

constraint forall(v in 1..n)(not burnt[0, v]);

constraint forall(t in 1..n, v in 1..n)(
  burnt[t, v] <-> (burnt[t-1, v] \/ exists(u in nbr[v])(burnt[t-1, u]) \/ burn_turn[v] = t)
);

% everything is burning at the end of the last turn
constraint forall(v in 1..n)(burnt[turns, v]);

solve minimize turns;

output ["turns = \(turns);\n",
        "sequence = \([v | t in 1..fix(turns), v in 1..n where fix(burn_turn[v]) = t]);\n"];
