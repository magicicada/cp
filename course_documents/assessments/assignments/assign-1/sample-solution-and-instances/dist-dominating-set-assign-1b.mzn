int: n;                     % number of vertices
int: m;                     % number of edges
int: k;                     % distance for domination

array[1..m] of int: from;    % edge start vertices
array[1..m] of int: to;      % edge end vertices

set of int: NODE = 1..n;
set of int: DIST = 1..k;

% Decision variable: 1 if vertex i is in the dominating set
array[NODE] of var 0..1: decision;

array[NODE, DIST] of var 0..1: neighbours; 

constraint if (k == 0) then (
    forall (v in 1..n) ( decision[v] == 1 ) 
) else (
    forall (v in 1..n) ( neighbours[v,k] == 1 )
)endif;

constraint forall (d in DIST, v in NODE) (
    if (d == 1) then (
        if ((decision[v] == 1) \/
            exists(e in 1..m where from[e] == v) (decision[to[e]] == 1) \/
            exists(e in 1..m where to[e] == v) (decision[from[e]] == 1)
        ) then (neighbours[v,d] == 1) else (neighbours[v,d] == 0) endif
    )
    elseif ((decision[v] == 1) \/ 
        (neighbours[v, (d-1)] == 1) \/
        exists(e in 1..m where from[e] == v) (neighbours[to[e], (d-1)] == 1) \/
        exists(e in 1..m where to[e] == v) (neighbours[from[e], (d-1)] == 1) 
    ) then (neighbours[v,d] == 1) else (neighbours[v,d] == 0) endif
);

solve minimize sum(decision)