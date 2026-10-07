int: n;
set of int: NODE = 1..n;
int: m;
set of int: EDGE = 1..m;
array[EDGE] of NODE: from;
array[EDGE] of NODE: to;
int: k;
set of int: COLOUR = 1..n;


array[NODE] of var COLOUR: colours;

%colours[2] <- will be assigned the colour for vertex 2


constraint forall(e in EDGE)(colours[from[e]] != colours[to[e]]);
constraint max(colours) < k;

solve satisfy


%solve minimize max(colours)

