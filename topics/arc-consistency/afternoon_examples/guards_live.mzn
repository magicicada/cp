%
% NOTE: 
% (0) enumerated types
% (1) what are our decision variable?
% (2) logical connectives /\ -> ...
% (3) constraints that define workforce directives
% (4) constraints that define legal coverage/obligation of rota
% (5) shameless goal, minimize people employed
% (6) in optimization, counting things that meet a condition (s != OFF)
%
enum GUARDS;
enum SHIFT = {DAY,NGT,OFF}; % guard is on DAY or NIGHT shift or is OFF

int: nDays; 
set of int: DAYS = 1..nDays;

int: lwbDay;
int: upbDay;
int: lwbNight;
int: upbNight;

int: budget; % the number of person shifts we can afford

% our decision variables
array[GUARDS,DAYS] of var SHIFT: roster; % roster[g,d] = s <-> guard g is on shift s on day d

% (3) constraints that define workforce directives
%  (a) a guard can work at most two consecutive day shifts
constraint forall(g in GUARDS)(forall(d in 1..nDays-2)(not (roster[g, d] == DAY /\ roster[g, d+1] ==DAY /\ roster[g, d+2] ==DAY)));
%  (b) a guard cannot go directly from a night shift to a day shift
constraint forall(g in GUARDS)(forall(d in 1..nDays-1)(not (roster[g, d]==NGT /\ roster[g,d+1] ==DAY)));
%  (d) a guard can work at most three night shifts in succession
constraint forall(g in GUARDS)(forall(d in 1..nDays-3) (not(roster[g, d] == NGT /\ roster[g, d+1] == NGT /\ roster[g, d+2] == NGT /\ roster[g, d+3] == NGT)));

% (4) constraints that define legal coverage/obligation of rota
% min and max cover

% respect the budget
% var int: cost = sum(g in GUARDS, d in DAYS)(if roster[g, d] != OFF then 1 else 0 endif);
var int: cost = sum(g in GUARDS, d in DAYS)(roster[g, d] != OFF);
constraint cost <= budget;

solve satisfy;

output ["\(roster[g,d])" ++ if d=nDays then "   "++show(g)++"\n" else " " endif | g in GUARDS, d in DAYS];
output["total shifts worked: \(cost)"];