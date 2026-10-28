% Lab 3 reference solution, Task 5: covering model.
% (x_1, ..., x_b) burns G iff every vertex u has d(u, x_i) <= b - i for some i.
% No simulation variables: distances are computed as parameters.

int: n;                      % number of vertices
int: m;                      % number of edges

array[1..m] of int: from;    % one end of each edge
array[1..m] of int: to;      % the other end of each edge

array[1..n] of set of int: nbr =
  [ {to[e] | e in 1..m where from[e] = v} union {from[e] | e in 1..m where to[e] = v}
  | v in 1..n ];

function set of int: ball(int: v, int: r) =
  if r = 0 then {v}
  else let { set of int: B = ball(v, r-1) } in B union array_union([nbr[u] | u in B])
  endif;

bool: connected = card(ball(1, n)) = n;
int: ecc_bound(int: v) = min([r | r in 0..n-1 where card(ball(v, r)) = n]);
int: UB = if connected then min([ecc_bound(v) | v in 1..n]) + 1 else n endif;

% d[u, v] = distance, capped at UB (anything further never matters)
array[1..n, 1..n] of int: d =
  let { array[1..n, 0..UB] of set of int: B = array2d(1..n, 0..UB, [ball(v, r) | v in 1..n, r in 0..UB]) }
  in array2d(1..n, 1..n, [ min([r | r in 0..UB where u in B[v, r]] ++ [UB + 1]) | u, v in 1..n ]);

array[1..n] of var 0..UB: burn_turn;
var 1..UB: turns;

constraint forall(t in 1..UB)(sum(v in 1..n)(burn_turn[v] = t) = (t <= turns));

% every vertex is within distance turns - t of the vertex chosen at some turn t
constraint forall(u in 1..n)(
  exists(v in 1..n)(burn_turn[v] > 0 /\ d[u, v] <= turns - burn_turn[v])
);

% Try small values of turns first (so the search behaves like solving the
% decision version for T = 1, 2, ...), then place the fires.
solve :: seq_search([
           int_search([turns], input_order, indomain_min),
           int_search(burn_turn, first_fail, indomain_max)])
      minimize turns;

output ["turns = \(turns);\n",
        "sequence = \([v | t in 1..fix(turns), v in 1..n where fix(burn_turn[v]) = t]);\n"];
