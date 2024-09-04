int: n;
int: max_time;
set of int: NODE = 1..n;
int: m;
set of int: EDGE = 1..m;
int: no_m;
set of int: NO_EDGE = 1..no_m;
array[EDGE] of NODE: from;
array[EDGE] of NODE: to;
array[NO_EDGE] of NODE: no_from;
array[NO_EDGE] of NODE: no_to;

array[NODE] of var 1..: start_time;
array[NODE] of var 1..: end_time;


