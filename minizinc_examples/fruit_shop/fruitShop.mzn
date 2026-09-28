
enum FRUIT;  

% cost and profit and quanities
array[FRUIT] of int: cost; % cost per unit of fruit
array[FRUIT] of int: profit; % profit per unit of fruit
array[FRUIT] of int: quantity; % how much of each fruit
int: budget; % how much we have to spend

% Variables: how much should we buy of each fruit?
array[FRUIT] of var int: purchasedQuantity;
var int: totalProfit;

% Can't donate fruit and you can't buy more fruit than is available!
constraint forall(f in FRUIT)(0 <= purchasedQuantity[f] /\ purchasedQuantity[f] <= quantity[f]); 
% this is how much you spend, and stay within budget
constraint sum(f in FRUIT)(purchasedQuantity[f] * cost[f]) <= budget;
% this is how much profit you will make
constraint totalProfit = sum(f in FRUIT)(purchasedQuantity[f] * profit[f]);

solve maximize(totalProfit);

output ["totalProfit = \(totalProfit) \n"];
output ["totalSpend = \(sum(f in FRUIT)(purchasedQuantity[f] * cost[f])) \n"];
output ["purchasedQuanity = \(purchasedQuantity) \n"];
output ["\(FRUIT)"];