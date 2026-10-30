% Graph burning: CP sample solution (simulation model)

include "alldifferent_except_0.mzn";

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

% Upper bound on the number of turns. If G is connected, choosing a centre at
% turn 1 burns everything by turn rad(G) + 1. Otherwise choosing every vertex
% in turn certainly works, so n is a bound.
bool: connected = card(ball(1, n)) = n;
function int: ecc(int: v) = min([r | r in 0..n-1 where card(ball(v, r)) = n]);
int: UB = if connected then min([ecc(v) | v in 1..n]) + 1 else n endif;

% burn_turn[v] = t if v is chosen at turn t, and 0 if v is never chosen
array[1..n] of var 0..UB: burn_turn;

% the number of turns taken to burn the whole graph
var 1..UB: turns;

% burnt[t, v]: v is burning at the end of turn t
array[0..UB, 1..n] of var bool: burnt;

% spread[t, v]: v is burning after the spread in turn t, before the choice
array[1..UB, 1..n] of var bool: spread;

% --- The burning sequence ---------------------------------------------------

% (A) 
constraint alldifferent_except_0(burn_turn);

% (B) 
constraint forall(v in 1..n)(burn_turn[v] <= turns);

% (C) 
constraint count(v in 1..n)(burn_turn[v] > 0) = turns;

% --- Simulating the fire ----------------------------------------------------

% (D) 
constraint forall(v in 1..n)(not burnt[0, v]);

% (E) 
constraint forall(t in 1..UB, v in 1..n)(
  spread[t, v] <-> (burnt[t-1, v] \/ exists(u in nbr[v])(burnt[t-1, u]))
);

% (F) 
constraint forall(t in 1..UB, v in 1..n)(
  burnt[t, v] <-> (spread[t, v] \/ burn_turn[v] = t)
);

% (G) 
constraint forall(v in 1..n)(burnt[turns, v]);

% --- Removing redundant choices ---------------------------------------------

% (H) 
constraint forall(t in 1..UB, v in 1..n)(
  burn_turn[v] = t -> (not spread[t, v] \/ forall(u in 1..n)(spread[t, u]))
);

% Fix turns first, trying small values first: this behaves like solving the
% decision problem for T = 1, 2, ... in order. Then choose the fires.
solve :: seq_search([
           int_search([turns], input_order, indomain_min),
           int_search(burn_turn, first_fail, indomain_max)])
      minimize turns;

output ["turns = \(turns);\n",
        "sequence = \([v | t in 1..fix(turns), v in 1..n where fix(burn_turn[v]) = t]);\n"];
