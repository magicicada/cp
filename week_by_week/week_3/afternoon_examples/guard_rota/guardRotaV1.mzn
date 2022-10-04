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

%
% WORKING DIRECTIVES
%
% No more than two consecutive DAY shifts
constraint forall(d in 1..(nDays-2),g in GUARDS)((roster[g,d] = DAY) /\ (roster[g,d+1] = DAY) -> (roster[g,d+2] != DAY));
% No DAY shift immediately after a NIGHT shift (after NIGHT must be NIGHT or OFF)
constraint forall(d in 1..(nDays-1),g in GUARDS)((roster[g,d] = NGT) -> (roster[g,d+1] != DAY));
% No more than three consecutive NGT shifts
constraint forall(d in 1..(nDays-3),g in GUARDS)((roster[g,d] = NGT) /\ (roster[g,d+1] = NGT) /\ (roster[g,d+2] = NGT) -> (roster[g,d+3] != NGT));

%
% LEGAL COVERAGE/OBLIGATION TO BE MET
%
% the number of guards that must be on duty in each shift of each day
constraint forall(d in DAYS)(sum (g in GUARDS)((roster[g,d] = DAY)) >= lwbDay);
constraint forall(d in DAYS)(sum (g in GUARDS)((roster[g,d] = DAY)) <= upbDay);
constraint forall(d in DAYS)(sum (g in GUARDS)((roster[g,d] = NGT)) >= lwbNight);
constraint forall(d in DAYS)(sum (g in GUARDS)((roster[g,d] = NGT)) <= upbNight);

%
% BUDGET CONSTRAINT
%
% can we meet coverage within budget?
var int: shiftsWorked = sum(d in DAYS)(sum(g in GUARDS)(roster[g,d] != OFF));
constraint shiftsWorked <= budget;
solve satisfy;

output ["\(roster[g,d])" ++ if d=nDays then "   "++show(g)++"\n" else " " endif | g in GUARDS, d in DAYS];
output["total shifts worked: \(shiftsWorked)"];