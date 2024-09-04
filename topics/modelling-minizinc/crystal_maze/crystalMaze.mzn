%
% Crystal Maze, first attempt
%

var 0..7: v0;
var 0..7: v1;
var 0..7: v2;
var 0..7: v3;
var 0..7: v4;
var 0..7: v5;
var 0..7: v6;
var 0..7: v7;

constraint abs(v0-v1) > 1;
constraint abs(v0-v5) > 1;
constraint abs(v0-v6) > 1;
constraint abs(v1-v2) > 1;
constraint abs(v1-v6) > 1;
constraint abs(v1-v7) > 1;
constraint abs(v2-v3) > 1;
constraint abs(v2-v6) > 1;
constraint abs(v2-v7) > 1;
constraint abs(v3-v4) > 1;
constraint abs(v3-v7) > 1;
constraint abs(v4-v5) > 1;
constraint abs(v4-v6) > 1;
constraint abs(v4-v7) > 1;
constraint abs(v5-v6) > 1;
constraint abs(v5-v7) > 1;
constraint abs(v6-v7) > 1;

include "alldifferent.mzn";
constraint alldifferent([v0,v1,v2,v3,v4,v5,v6,v7]);

solve satisfy;
