% Lab 2 reference solution, Part B: covering model with parameter-level balls

int: n;
int: m;
int: k;

array[1..m] of int: from;
array[1..m] of int: to;

array[1..n] of set of int: nbr =
  [ {to[e] | e in 1..m where from[e] = v} union {from[e] | e in 1..m where to[e] = v}
  | v in 1..n ];

array[1..n] of var 0..1: decision;

% ball(v, r): the vertices at distance at most r from v
function set of int: ball(int: v, int: r) =
  if r = 0 then {v}
  else let { set of int: B = ball(v, r-1) } in B union array_union([nbr[u] | u in B])
  endif;

constraint forall(v in 1..n)(sum(u in ball(v, k))(decision[u]) >= 1);

solve minimize sum(decision);
