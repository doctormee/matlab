%% example #1 (k = 2)
clc
clear
f = @(x) cos(x(1)) + sin(x(2));
k = 2;
n = 200;
xmin = -5;
xmax = 12;
allRoots(f, n, k, xmin, xmax);
%% example #2 (k = 2)
clc
clear
f = @(x) (x(1) + 2).^ 2 + (x(2) - 3).^2;
k = 2;
n = 3;
xmin = -2;
xmax = 3;
allRoots(f, n, k, xmin, xmax);
%% example #4 (k = 4)
clc
clear
f = @(x) x(1) + x(2) + x(3) + x(4);
k = 4;
n = 1600;
xmin = -7;
xmax = 7;
allRoots(f, n, k, xmin, xmax);
%% example #5 (k = 5)
f = @(x) (x(1) - 1)*x(2)*(x(3) + 2)*(x(4) - 5)*x(5);
k = 5;
n = 75;
xmin = -4;
xmax = 4;
allRoots(f, n, k, xmin, xmax);