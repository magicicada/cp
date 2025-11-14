int: n; int: m; int: k;
array[1..m] of int: from;
array[1..m] of int: to;     

array[1..n] of var 0..1: decision;
array[0..k, 1..n] of var bool: in_dist;

constraint forall(i in 1..n)( in_dist[0,i] <-> (decision[i] = 1) );

constraint
  forall(t in 1..k, i in 1..n)(
    in_dist[t,i] <->
      in_dist[t-1,i] \/
      exists(j in 1..m where to[j] = i)( in_dist[t-1, from[j]] ) \/
      exists(j in 1..m where from[j] = i)( in_dist[t-1, to[j]] )
  );

constraint forall(i in 1..n)( in_dist[k,i] );

solve minimize sum(i in 1..n)(decision[i]);