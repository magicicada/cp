% setup bits
include "alldifferent.mzn";


% variable bits
var 0..7: a;
var 0..7: b;
var 0..7: c;
var 0..7: d;
var 0..7: e;
var 0..7: f;
var 0..7: g;
var 0..7: h;

%constraint bits
constraint abs(a-b) > 1;
constraint abs(a-c) > 1;
constraint abs(a-d) > 1;
constraint abs(a-e) > 1;
constraint abs(b-d) > 1;
constraint abs(b-e) > 1;
constraint abs(b-f) > 1;
constraint abs(c-d) > 1;
constraint abs(c-g) > 1;
constraint abs(d-e) > 1;
constraint abs(d-g) > 1;
constraint abs(d-h) > 1;
constraint abs(e-f) > 1;
constraint abs(e-g) > 1;
constraint abs(e-h) > 1;
constraint abs(f-h) > 1;
constraint abs(g-h) > 1;

constraint alldifferent([a, b, c, d, e, f, g, h]);

% solution call
solve satisfy