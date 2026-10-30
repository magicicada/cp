% Graph burning: ILP sample solution (covering model)
%
% A sequence (x_1, ..., x_b) burns G iff every vertex u has d(u, x_i) <= b - i
% for some i: the fire lit at turn i has radius b - i by the end of turn b.
% Every constraint below is a linear equation or inequality.

int: n;                      % number of vertices
int: m;                      % number of edges

array[1..m] of int: from;    % one end of each edge
array[1..m] of int: to;      % the other end of each edge

% nbr[v] is the set of neighbours of v (a parameter, computed before solving)
array[1..n] of set of int: nbr =
  [ {to[e] | e in 1..m where from[e] = v} union {from[e] | e in 1..m where to[e] = v}
  | v in 1..n ];

% ball(v, r) is the set of vertices at distance at most r from v
function set of int: ball(int: v, int: r) =
  if r = 0 then {v}
  else let { set of int: B = ball(v, r-1) } in B union array_union([nbr[u] | u in B])
  endif;

% Upper bound on the number of turns, as in the CP model
bool: connected = card(ball(1, n)) = n;
function int: ecc(int: v) = min([r | r in 0..n-1 where card(ball(v, r)) = n]);
int: UB = if connected then min([ecc(v) | v in 1..n]) + 1 else n endif;

% d[u, v] is the distance from u to v, capped at UB (larger distances never matter)
array[1..n, 1..n] of int: d =
  let { array[1..n, 0..UB] of set of int: B =
          array2d(1..n, 0..UB, [ball(v, r) | v in 1..n, r in 0..UB]) }
  in array2d(1..n, 1..n,
       [ min([r | r in 0..UB where u in B[v, r]] ++ [UB]) | u, v in 1..n ]);

% Radii a fire can have at the end of the last turn
set of int: RADIUS = 0..UB-1;

% x[v, r] = 1 if v is chosen at turn turns - r, so that its fire has radius r
% at the end of the last turn
array[1..n, RADIUS] of var 0..1: x;

% y[r] = 1 if some vertex is lit with radius r, that is, if r < turns
array[RADIUS] of var 0..1: y;

% the stub's variables
array[1..n] of var 0..UB: burn_turn;
var 1..UB: turns;

% --- The burning sequence ---------------------------------------------------

% (A) 
constraint forall(r in RADIUS)(sum(v in 1..n)(x[v, r]) = y[r]);

% (B) 
constraint forall(r in 1..UB-1)(y[r] <= y[r-1]);

% (C) 
constraint turns = sum(r in RADIUS)(y[r]);

% (D) 
constraint forall(v in 1..n)(sum(r in RADIUS)(x[v, r]) <= 1);

% --- Covering ---------------------------------------------------------------

% (E) 
constraint forall(u in 1..n)(
  sum(v in 1..n, r in RADIUS where d[u, v] <= r)(x[v, r]) >= 1
);

% --- Recovering burn_turn for the output ------------------------------------

% (F) 
constraint forall(v in 1..n)(
  let { var int: chosen = sum(r in RADIUS)(x[v, r]);
        var int: radius = sum(r in RADIUS)(r * x[v, r]) } in
       burn_turn[v] <= UB * chosen
    /\ burn_turn[v] <= turns - radius + UB * (1 - chosen)
    /\ burn_turn[v] >= turns - radius - UB * (1 - chosen)
);

solve minimize turns;

output ["turns = \(turns);\n",
        "sequence = \([v | t in 1..fix(turns), v in 1..n where fix(burn_turn[v]) = t]);\n"];
