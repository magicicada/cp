% Magic square: fill an n x n grid with the numbers 1..n^2, each used once,
% so that every row, column and both main diagonals have the same sum.

include "globals.mzn";

int: n = 3;
set of int: IDX = 1..n;
int: magic = n * (n*n + 1) div 2;    % the common sum is forced

array[IDX, IDX] of var 1..n*n: sq;

constraint all_different(sq);

constraint forall(i in IDX)(sum(j in IDX)(sq[i,j]) = magic);
constraint forall(j in IDX)(sum(i in IDX)(sq[i,j]) = magic);
constraint sum(i in IDX)(sq[i,i]) = magic;
constraint sum(i in IDX)(sq[i,n+1-i]) = magic;

solve satisfy;

output [show_int(3, sq[i,j]) ++ if j = n then "\n" else "" endif
        | i, j in IDX];
