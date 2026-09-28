% Project scheduling: each task has a duration, some tasks must finish
% before others start, and tasks needing the single crane may not overlap.
% Minimise the finishing time of the whole project (the makespan).

int: n;
set of int: TASK = 1..n;
array[TASK] of string: name;
array[TASK] of int: duration;

int: n_prec;
array[1..n_prec, 1..2] of TASK: prec;   % row [a, b]: a finishes before b starts

set of TASK: crane;                     % tasks that need the crane

int: horizon = sum(duration);
array[TASK] of var 0..horizon: start;
var 0..horizon: makespan;

constraint forall(p in 1..n_prec)(
    start[prec[p,1]] + duration[prec[p,1]] <= start[prec[p,2]]
);

constraint forall(i, j in crane where i < j)(
    start[i] + duration[i] <= start[j] \/ start[j] + duration[j] <= start[i]
);

constraint forall(t in TASK)(start[t] + duration[t] <= makespan);

solve minimize makespan;

output [name[t] ++ ": \(start[t])-\(start[t] + duration[t])\n" | t in TASK]
    ++ ["makespan = \(makespan)\n"];
