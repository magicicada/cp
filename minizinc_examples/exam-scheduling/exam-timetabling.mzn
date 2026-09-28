% Exam timetabling: assign each exam to a time slot so that no student
% sits two exams in the same slot, and each slot's exams fit in the hall.
% Minimise the number of slots used.

int: n_exams;
set of int: EXAM = 1..n_exams;
array[EXAM] of string: name;
array[EXAM] of int: size;            % number of students sitting each exam

int: n_students;
set of int: STUDENT = 1..n_students;
array[STUDENT] of set of EXAM: takes; % exams taken by each student

int: n_slots;
set of int: SLOT = 1..n_slots;
int: hall_capacity;

array[EXAM] of var SLOT: slot;

% no student has two exams in the same slot
constraint forall(s in STUDENT, e1, e2 in takes[s] where e1 < e2)(
    slot[e1] != slot[e2]
);

% the exams in each slot fit in the hall
constraint forall(t in SLOT)(
    sum(e in EXAM)(size[e] * (slot[e] = t)) <= hall_capacity
);

solve minimize max(slot);

output [name[e] ++ ": slot \(slot[e])\n" | e in EXAM];
