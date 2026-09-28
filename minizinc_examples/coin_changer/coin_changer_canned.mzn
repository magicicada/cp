int: total = 100;
array[1..5] of int: coins = [1, 5, 10, 20, 50];

array[1..5] of var 0..100: counts;


constraint sum(i in 1..5)(counts[i] * coins[i]) = total;

var int: num_coins = sum(counts);
solve minimize num_coins; 
