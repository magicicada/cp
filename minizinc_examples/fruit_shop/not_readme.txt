FRUITSHOP
---------
We are the proud owners of a fruit shop. 

Each day we go to the fruit market and buy fruit to sell.

Each item of fruit has a cost, a profit and quantity available.

We have a budget, i.e. we go to market with so much money.

Assuming we can sell everything that we buy from the market ...
 - buy items of fruit such that it maximises our profit
 - spend no more than your budget
 - don't buy more than is available
 - you cannot sell to the market (i.e. cannot buy negative quantity)

> mzn-gecode fruitShop.mzn fruit1.dzn -s

What do we learn?
-----------------
- Input as a dzn (again).
- enum type i.e. access an array by type of fruit!
   - forall(f in FRUIT)(...);
- sum
   - sum(f in FRUIT)(...) <= budget;
- optimization ... maximize(totalProfit)
- comments in model
- output stuff

ToDo
----
Look at decision problem!

