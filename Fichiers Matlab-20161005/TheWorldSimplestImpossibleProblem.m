% TheWorldSimplestImpossibleProblem.m
% Find 3 numbers whose average is 3 yields an infinite number of solutions, some are more interseting than others

%% Init
clear

%% A matrix
A = [1/3, 1/3, 1/3];

%% b
b = 3;

%% L2 solution
x.Data = pinv(A) * b;
x.L2Norm = norm (x.Data, 2);
x.L0Norm = sum (x.Data ~= 0);

%% L0 solution
y.Data = A\b;
y.L2Norm = norm (y.Data, 2);
y.L0Norm = sum (y.Data ~= 0);

%% Display
x
y
