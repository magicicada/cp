int: n;
set of int: NODE = 1..n;
int: m;
set of int: EDGE = 1..m;
array[EDGE] of NODE: from;
array[EDGE] of NODE: to;
int: k;
set of int: COLOUR = 1..k;
array[NODE] of var COLOUR: colour;
constraint forall(e in EDGE)(
colour[from[e]] != colour[to[e]]
);
solve minimize max(colour);