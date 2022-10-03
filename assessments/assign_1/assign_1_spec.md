---
tags: cp, teaching, 2022
---

# Assignment 1:  Due October 11th

Note that this assignment will be automatically marked. Code that does not run will get zero marks.  

## Task 1 **[2 marks]**:
You will write a MiniZinc model for a simple single instance of a graph colouring problem.  Consider the map of Canada with provinces and territories labeled: 
![](https://i.imgur.com/P7iiRhr.png)
(from: Lokal_Profil image cut to remove Canada and move Alaska closer by Paul Robinson, CC BY-SA 2.5 <https://creativecommons.org/licenses/by-sa/2.5>)

Write a model to assigns colours (which you should denote as positive integers in the set $\{1, 2, 3\}$) to provinces/territories so that:
- two provinces/territories sharing a border have different colours
- assume that NU borders all of NT, MB, ON, QC, NL
- assume that PE borders all of QC,  NL,  NB, NS, and is coloured 3
- YT is coloured 1
- you use only three colours

It **must** be possible to run your code with the command-line call:

`minizinc colour_can.mzn`

Your output should be one province/territory per line with the colour assigned to it in the format:
`<PROVINCE> = <COLOUR>;`
e.g.: 
`YT = 1;`

Indicating that YT is assigned colour 1


## Task 2 **[8 marks]**: 
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
