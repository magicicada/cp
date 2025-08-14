enum PRODUCT;

array[PRODUCT] of int: value;

enum RESOURCE;
array[RESOURCE] of int: supply;
array[PRODUCT,RESOURCE] of int: demand;

% variables
array[PRODUCT] of var int: num_made;
var int: total_value = sum(p in PRODUCT)(value[p] * num_made[p]);


% constraints
constraint forall(r in RESOURCE) (sum (p in PRODUCT)(demand[p,r]*num_made[p]) <= supply[r]);
constraint forall(p in PRODUCT) (num_made[p] >= -10);


solve maximize total_value;

