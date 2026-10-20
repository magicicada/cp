% Lab 2 reference solution, Part A: layered model with linear 0-1 constraints only

int: n;
int: m;
int: k;

array[1..m] of int: from;
array[1..m] of int: to;

array[1..n] of set of int: nbr =
  [ {to[e] | e in 1..m where from[e] = v} union {from[e] | e in 1..m where to[e] = v}
  | v in 1..n ];

array[1..n] of var 0..1: decision;

% reach[t, v] may be 1 only if v is within distance t of a chosen vertex.
array[0..k, 1..n] of var 0..1: reach;

constraint forall(v in 1..n)(reach[0, v] = decision[v]);

constraint forall(t in 1..k, v in 1..n)(
  reach[t, v] <= reach[t-1, v] + sum(u in nbr[v])(reach[t-1, u])
);

constraint forall(v in 1..n)(reach[k, v] = 1);

solve minimize sum(decision);
