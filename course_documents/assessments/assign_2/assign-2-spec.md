# Assignment 2 Specification - Compare Solvers

In this assignment you will compare the performance of two styles of solver on a graph-defense problem related to the firefighter problem that we will discuss in lecture.  You will implement both:
- a CP model for this problem in MiniZinc (callable within Python), and 
- an ILP model callable in Python using either OR-tools or PuLP 

I will provide stub code that shows how I will run your models.  The correctness of your models will be assessed automatically, so it is important that your code runs exactly as I would expect it to.  

## The Problem:
You will implement both a CP and an ILP model for the Infectious Defence Firefighter Problem.  In this problem, you are given as input a graph $G = (V, E)$ with a root $r$ denoting the starting point of the fire.  Then, on each turn the following happens in this order:
1. You choose an additional unburning vertex to defend
2. All undefended vertices that are adjacent to a burning vertex catch fire
3. All unburning and undefended vertices that are adjacent to a defended vertex become defended.  

The process ends when there are no burning vertices adjacent to undefended unburning vertices - that is, the fire can spread no further.  The number of vertices *saved* is the number of unburning vertices at the end of the process.  Note that the main difference between this process and the firefighter game that we discussed in lecture is that here the defence spreads.

## Task 1: (weighted 10\%)
Implement a CP model for this problem in MiniZinc.  Details of code that will call your model (in Python) to follow.  I will assess the correctness and efficiency of your model automatically.

## Task 2: (weighted 10\%)
Implement an ILP model for this problem using either PuLP or OR-Tools.  Details of code that will call your model (in Python) to follow.  I will assess the correctness and efficiency of your model automatically.

## Task 3: (weighted 80\%)
Write *at most one page* comparing the performance of your CP and your ILP models.  This should include a short section describing any interesting insights that you used in designing your models, a section outlining your experimental pipeline and why you have chosen to design it as you have, a plot or table showing the performances of the two models, and a section describing what you see in the results.  Submit this as a PDF.  Do not submit more than one page.  We will only read and mark one page.  

## FAQ: What if I can't get Task 1 and 2 working, how can I do Task 3?
Even if you cannot get both models working, you can still get part marks for Task 3. The suggestions below are only for it you cannot get both models working. 

For the visualisation or table and description of results:
- If you have one runnable model (that may be giving incorrect answers):
    - Compare your model against itself in some meaningful way.  For example, if you have implemented the Minizinc model, you could compare performance of different solvers on your Minizinc model (https://python.minizinc.dev/en/latest/getting_started.html#using-different-solvers), or compare with and without some optimisation you've made.  You could also compare your solver's performance on different types of instances - this would need a different type of visualisation than the one we say in lecture.
- If both models are runnable (but again may be giving incorrect answers):
    - compare the models against each other as you would if they were correct, and we will still mark the visualisation/table reporting approach and the discussion of what you can see in those results.

For the section on pipeline: you can describe this even if you don't have a working model, and are using one of the options for runnable but incorrect models above.

For the section on insights about your model or models: reflect on what you can about what does and doesn't work, and why you think that might be.  
