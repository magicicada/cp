%
% Optimization problem ... "What is the greatest value we can get from our production?"
%
% To run on command line:
% mzn-gecode prod-plan-dec.mzn prod-plan-weapon.dzn -s -a
%

% products 
enum PRODUCT;  
% value (to producer) per unit for each product
array[PRODUCT] of int: value; 

% resources, things used to make products
enum RESOURCE; 
% Amount of each resource available
array[RESOURCE] of int: supply; 

% Units of each resource required to produce single unit of product
array[PRODUCT,RESOURCE] of int: demand; 

% decision variables: how much should we make of each product?
array[PRODUCT] of var int: quantity;

% Must produce a non-negative amount!
constraint forall(p in PRODUCT)(quantity[p] >= 0);

% Production can only use the available resources:
constraint forall (r in RESOURCE)(sum (p in PRODUCT)(demand[p,r] * quantity[p]) <= supply[r]); 

% Maximize production value
var int: totalValue = sum(p in PRODUCT)(value[p] * quantity[p]);
solve maximize totalValue;

output [ "\(p): \(quantity[p])\n" | p in PRODUCT ]++["totalvalue: \(totalValue)"];