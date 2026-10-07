int: total = 75;
array[1..5] of int: coins = [1, 5, 10, 20, 50];
%array[1..5] of int: coins = [50, 20, 10, 5, 1];

array[1..5] of var 0..100: counts;

%Add a constraint requiring the selected coins to sum to total.
constraint sum(i in 1..5)(counts[i]*coins[i]) = total;
%constraint sum(i in 1..5)(counts[i]) <= 10;
%constraint sum(counts) <=10;

solve minimize sum(counts);