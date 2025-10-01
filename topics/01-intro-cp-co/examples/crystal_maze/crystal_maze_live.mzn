% setup bits

% variable bits
var 0..7: a;
var 0..7: b;
var 0..7: c;
var 0..7: d;
var 0..7: e;
var 0..7: f;
var 0..7: g;
var 0..7: h;

% constraints
constraint abs(a - b) > 1;
constraint abs(a - e ) > 1;
constraint abs(a - g) > 1;

constraint abs(b - e) > 1;
constraint abs(b - f) > 1;
constraint abs(b - c) > 1;
constraint abs(b - h) > 1;
constraint abs(b - g) > 1;



% solution
solve satisfy;