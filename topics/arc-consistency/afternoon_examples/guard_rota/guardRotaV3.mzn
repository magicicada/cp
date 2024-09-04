%
% Use of global cardinality constraint
% Note also "array comprehension" in line 31
%
include "globals.mzn";
enum GUARDS;
enum SHIFT = {DAY,NGT,OFF}; % guard is on DAY or NIGHT shift or is OFF

int: nDays; 
set of int: DAYS = 1..nDays;

int: lwbDay;
int: upbDay;
int: lwbNight;
int: upbNight;

int: budget; % the number of person shifts we can afford

array[GUARDS,DAYS] of var SHIFT: roster; % roster[g,d] = s <-> guard g is on shift s on day d

% No more than two consecutive DAY shifts
constraint forall(d in 1..(nDays-2),g in GUARDS)(roster[g,d] = DAY /\ roster[g,d+1] = DAY -> roster[g,d+2] != DAY);
% No DAY shift immediately after a NIGHT shift (after NIGHT must be NIGHT or OFF)
constraint forall(d in 1..(nDays-1),g in GUARDS)(roster[g,d] = NGT -> roster[g,d+1] != DAY);
% No more than three consecutive NGT shifts
constraint forall(d in 1..(nDays-3),g in GUARDS)(roster[g,d] = NGT /\ roster[g,d+1] = NGT /\ roster[g,d+2] = NGT -> roster[g,d+3] != NGT);

% the number of guards that must be on duty in each shift of each day
array[DAYS] of var lwbDay..upbDay: totalOnDay;
array[DAYS] of var lwbNight..upbNight: totalOnNight;
constraint forall(d in DAYS)(global_cardinality([roster[g,d] | g in GUARDS],[DAY,NGT],[totalOnDay[d],totalOnNight[d]]));

% all guards are equal!
constraint forall(g1,g2 in GUARDS where g1<g2)(lex_greatereq(row(roster,g1),row(roster,g2)));

% can we meet coverage within budget?
var int: shiftsWorked = sum(d in DAYS)(sum(g in GUARDS)(roster[g,d] != OFF));
constraint shiftsWorked <= budget;
solve satisfy;
%solve minimize shiftsWorked;

output ["\(roster[g,d])" ++ if d=nDays then "   "++show(g)++"\n" else " " endif | g in GUARDS, d in DAYS];
output["total shifts worked: \(shiftsWorked)"];
