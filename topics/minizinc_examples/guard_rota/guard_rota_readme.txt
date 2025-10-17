
Guard Rota
----------
We have a number of security guards and a number of days.

Each day is broken into two shifts, day and night (DAY,NGT).

We are contracted to deliver a minimum and maximum cover
of guards on each shift.

On any day, a guard is either working on a day or night shift
or is off. 

There is a working directive such that:

 (a) a guard can work at most two consecutive day shifts
 (b) a guard cannot go directly from a night shift to a day shift
 (d) a guard can work at most three night shifts in succession

Guards only get paid for the days they work, i.e. when they are
off they are not paid ... this is a zero hours contract world

Given a budget, for example 42 days of paid work, can we
meet our contracted cover while respecting the working directive?


What do we learn?
-----------------
We have four models, gradually improving, each addressing the above decision problem.

Model V1: gives a simple/intuitive model, and introduces important concepts

   % (0) enumerated types
   % (1) what are our decision variable?
   % (2) logical connectives /\ -> ...
   % (3) constraints that define workforce directives
   % (4) constraints that define legal coverage/obligation of rota
   % (5) shameless goal, minimize people employed
   % (6) in optimization, counting things that meet a condition (s != OFF)

Model V2: makes better use of variables and makes the stunning observation ...
          "All guards are equal" ... symmetry breaking with lex constraint

Probably won't get to:
Model V3: uses the global cardinality constraint, and we can see its effect on search.

