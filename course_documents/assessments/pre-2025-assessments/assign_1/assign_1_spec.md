# Assignment 1:  Simple Modelling in MiniZinc

Note that this assignment will be automatically marked. Code that does not run will get zero marks. Sample marking code will be provided for you to check your code with. Be absolutely sure that your output format is as required.  

## Task 1 **[weighted 20%]**:
You will write a MiniZinc model for a simple single instance of a graph colouring problem.  Consider the map of Nova Scotia at ![image](https://github.com/user-attachments/assets/af2035de-2fa6-4240-bca9-e7bdb532d8c4) (and ignore the colouring by government type, that is clearly not a proper colouring.)

(from: (https://en.wikipedia.org/wiki/List_of_counties_of_Nova_Scotia#/media/File:Nova_Scotia_counties_2015.png))

Write a model to assign colours (which you should denote as positive integers in the set $\{1, 2, 3, 4\}$) to counties so that:
- counties sharing a border have different colours
- corner adjacencies are not adjacencies (if in doubt, ask in an afternoon session)
- A few clarifications:
  - Inverness borders Guysborough, Antigonish, Victoria, Richmond, but not Cape-Breton
  - Richmond borders Cape Breton, Inverness, Guysborough, but not Victoria
  - Cumberland borders only Colchester
  - Yarmouth borders Digby and Shelburne but not Queens
  - Shelburne does not border Dignby
- Antigonish is coloured 3
- you use only four colours

It **must** be possible to run your code with the command-line call:

`minizinc colour_ns.mzn`

Your output should be one province/territory per line with the colour assigned to it in the format:
`<COUNTY> = <COLOUR>;`
e.g.: 
`Antigonish = 3;`

Indicating that Antigonish is assigned colour 3

You should typeset Cape Breton as 'Cape-Breton' in your solution (this is what the marking code uses)

You can check your solution against the marking code by running:  

`minizinc colour_ns.mzn | python mark_colour_ns.py` 
(a report of 6 marks is full marks for those tests. I may add more tests, but the format will remain the same)


## Task 2 **[weighted 80%]**: 
You will write a MiniZinc model for scheduling of guests visiting at a castle.  

(This assignment inspired by the Duke of Densmore by Claude Berge - a mathematical story that's quite hard to find in print.)

I am a fancy person who lives in a castle. Various of my friends are coming to visit, and I am heartless so I have given them all numbers for convenience.  I am very keen that some of them meet each other and others do not, and as I am a graph theorist I have encoded this as graphs for my convenience.  For your convenience, it is a similar graph encoding format to one that we used for graph colouring in lecture.  My friends (identified by numbers `1..`) are nodes, and there is an edge between two friends if I require their visits to intersect so that they can meet each other.  For example:

```
max_time = 30;
n = 4;
m = 3;
from = [1, 1, 2];
to =   [2, 4, 3];
no_m = 1;
no_from = [1];
no_to = [3];
```
Indicates that I have 4 friends, and require that friends 1 and 2 must meet at some point, friends 1 and 4 must meet at some point, etc., as well as that friends 1 and 3 never meet.  For those I haven't specified, I don't mind whether they meet or not.  There are more constraints to follow.

I want to make a schedule for when my friends will visit.  Each of them must be assigned a start day and an end day for their visit.   Days are in the range` 1..` Everyone stays at least one night, so their start day must be strictly less than their end day.  I am lazy, so only one friend may arrive each day, and only one friend may leave each day - but I will allow someone to arrive the same day someone else is leaving.  

Because I am a busy person, I want to finish up all this visiting quickly, so the last ending day should be as early as possible, and certainly no later than `max_time`.  

Please make have your output look like two lists, `start_time` and `end_time`, where start_time contains the start times of visits for the guests in order of their numbers, and the end times their corresponding end times.  So, for example:

```
start_time = [1, 2, 5, 3];
end_time = [4, 7, 6, 5];
```
Indicates that guest 1 arrives at time 1 and leaves at time 4, guest 2 arrives at time 2 and leaves at time 7, etc.  

It **must** be possible to run your code with the command-line call:

`minizinc time_intervals.mzn four_intervals.dzn`

And similarly for other .dzn files.
Stub code and the `four_intervals.dzn` file are available.

*Clarification: In the second task, when I require two guests to meet, their visits must overlap for a full day.  That is, it is not sufficient for one to leave and another to arrive on the same day.* 
