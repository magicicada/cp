% Optimisation version
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


var int: total_value = sum(p in PRODUCT)(value[p]*quantity[p]);

% solve
solve maximize total_value;

output [ "\(p): \(quantity[p])\n" | p in PRODUCT ]++["totalvalue: \(total_value)"];