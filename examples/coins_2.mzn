int: total;
total = 80;
array[1..5] of int: coins = [1, 5, 10, 20, 50];

array[1..5] of var 0..100: counts;

constraint sum(c in 1..5)(counts[c]*coins[c]) == total;
constraint counts[4] == 0;

solve minimize sum(counts)