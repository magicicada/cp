%
% Use variables to count number of DAY and NGT shifts in a day
% All guards are equal! Note forall with where and use or row
% NOTE: include "globals.mzn"
%       getting rid of excessive brackets ((fear) and (loathing))
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
array[DAYS] of var lwbDay .. upbDay: totalOnDay;
constraint forall(d in DAYS)(totalOnDay[d] = sum(g in GUARDS)(roster[g,d] = DAY));
array[DAYS] of var lwbNight .. upbNight: totalOnNight;
constraint forall(d in DAYS)(totalOnNight[d] = sum(g in GUARDS)(roster[g,d] = NGT));

% all guards are equal!
constraint forall(g1,g2 in GUARDS where g1<g2)(lex_greatereq(row(roster,g1),row(roster,g2)));

% can we meet coverage within budget?
var int: shiftsWorked = sum(d in DAYS)(sum(g in GUARDS)(roster[g,d] != OFF));
constraint shiftsWorked <= budget;
solve satisfy;

output ["\(roster[g,d])" ++ if d=nDays then "   "++show(g)++"\n" else " " endif | g in GUARDS, d in DAYS];
output["total shifts worked: \(shiftsWorked)"];
