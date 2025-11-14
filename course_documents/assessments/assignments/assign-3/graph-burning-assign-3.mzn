int: n;                     % number of vertices
int: m;                     % number of edges

array[1..m] of int: from;    % edge start vertices
array[1..m] of int: to;      % edge end vertices

% I am allowing two options for decision variables here to allow you to write the model as you want to. 
% Comment out the one that you do not want to use
% As in assignment 1, you may include other decision variables if they help you, but do not rename these
% you may change their range bounds if that is useful to you (that is, restrict their values downwards from all integers

% Decision variable option 1: set to t at position i if vertex i is selected for active burning on turn t, -1 otherwise
array[0..n] of var int: decision_1;
% Decision variable option 2: a 2D indicator that shows at what time you burn which vertex: 
% decision_2[i, j] should be set to 1 if you choose to burn vertex i at time j, 0 otherwise
array[0..n,0..n] of var int: decision_2;

solve satisfy;