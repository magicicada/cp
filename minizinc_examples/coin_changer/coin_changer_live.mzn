% Use this editor as a MiniZinc scratch book
int: total = 56;
array [1..6] of int: coins = [50, 20, 10, 5, 2, 1];

% variable array to capture counts of each coin denomination
array [1..6] of var 0..: counts;
var int: num_coins = sum(counts);
%var int: num_bigs = counts[6] + counts[5];
%array [1..6] of var 0..1: indicators;

%constraint forall i indicators[i]= 1 if 


constraint sum(i in 1..6)(counts[i]*coins[i]) = total;

solve minimize num_coins;