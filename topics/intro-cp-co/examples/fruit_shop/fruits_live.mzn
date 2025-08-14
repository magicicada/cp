int: min_profit;

enum FRUIT;  

% cost and profit and quanities
array[FRUIT] of int: cost; % cost per unit of fruit
array[FRUIT] of int: profit; % profit per unit of fruit
array[FRUIT] of int: quantity; % how much of each fruit is available
int: budget; % how much we have to spend


array[FRUIT] of var 0..: buy_quant;
% fruit - how many we buy of each kind

var int: actual_profit = sum(f in FRUIT)(buy_quant[f]*profit[f]);
% total profit (from our params and our number of fruits)

% Constraints:
% total cost under budget
constraint sum(f in FRUIT)(buy_quant[f]*cost[f]) <= budget;

% number of fruit available
% for each fruit, buy between 0 and number available
% constraint forall(f in FRUIT)(buy_quant[f] >= 3);
constraint forall(f in FRUIT)((buy_quant[f] <= quantity[f]) /\  (3 <= buy_quant[f]));
constraint actual_profit >= min_profit;

% We want to maximise:
% profit
% sum of products of fruit profit and quantities
% solve maximize(actual_profit)

solve satisfy;