% Optimisation version
% NOPE! NOW DECISION
int: target = 550000;

% parameters
enum PRODUCT;
array[PRODUCT] of int: value;
enum RESOURCE;
array[RESOURCE] of int: supply;
array[PRODUCT,RESOURCE] of int: demand;

% decision variables
% deciding how much of what to make
array[PRODUCT] of var 0..: quantity;

% constraints
% not spend more than we have
constraint forall(r in RESOURCE)
            (sum (p in PRODUCT) 
                  (quantity[p]*demand[p,r]) <= supply[r]
            );

constraint total_value >= target;

var int: total_value = sum(p in PRODUCT)(value[p]*quantity[p]);

% solve
solve satisfy;