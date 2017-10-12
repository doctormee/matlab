%% TASK 1
%drawing a function plot 
a = 0; %left border
b = 4 * pi; %right border
n = 100; %grid size
x = linspace(a, b, n); %linear grid
f = sin(x); %function (in this case - sine)
figure;
xlabel('X');
ylabel('Y');
hold on;
grid on;
plot(x, f);
[maxVal, maxIndex] = max(f);
[minVal, minIndex] = min(f);
plot(x(maxIndex), maxVal, 'r*', ...
    x(minIndex), minVal, 'b*');
legend('Sine', 'Maximum', 'Minimum');
%%  TASK 2
%input a number
n = input('Input a number:');
%natural check
if ((floor(n) == n) && (n > 0) && (isfinite(n)))
    disp('Number is natural');
else
    disp('Number is not natural');
    return; %if not natural - there is no sense in continuing
end;
numVec = 9 : 18 : n %vector of odd numbers, dividable by 9
lineVec = 1 : n; %a simple line
rowsMat = repmat(lineVec, n, 1).' %makes a matrix with i in i-th row
lineVec = 1 : n * (n + 1); %another line
bMat = reshape(lineVec, n + 1, n).' %into the matrix
cVec = bMat(:) %and back again
dMat = bMat(:, end - 1 : end) %finally, last two columns

%%  TASK 3
n = 7;
aMat = floor(100 * rand(n) + 1)
dmaxInt = max(diag(aMat))
prodVect = prod(aMat, 2) ./ sum(aMat, 2);
ymaxNum = max(prodVect)
yminNum = min(prodVect)
aMat = sortrows(aMat)

%%  TASK 4
xVec = (1:10)'
yVec = 1:10
tableMat = xVec * yVec

%%  TASK 5
%input
n = input('Input number');
if (isfinite(n) && isprime(n)) 
    disp('Number is prime');
else
    disp('Number is not prime');
    return;
end;
aMat = rndi(100, n)
bVec = rndi(100, n, 1)
if (det(aMat) == 0)
    disp('Determinant is 0');
    return;
end;
disp('Solvable');
disp('Solving via matrix division');
x1Vec = aMat\bVec
errorDiv = norm(aMat * x1Vec - bVec)
disp('Solving via LU-factorization');
x2Vec = linsolve(aMat, bVec)
errorLU = norm(aMat * x2Vec - bVec)
%%  TASK 6
n = rndi(10, 1)
m = rndi(10, 1)
aVec = rndi(200, 1, n) - 100
bVec = rndi(200, 1, m) - 100
max1Num = max(aVec) - min(bVec);
max2Num = max(bVec) - min(aVec);
maxNum = max(max1Num, max2Num)
%%  TASK 7
n = 5;
k = 3;
%pMat = 100 * rand(n, k)
pMat = [0, 0, 0; 1, 0, 0; -1, 0, 0; 1, 0, 1; 2, 0, -2]
pMat = pMat.';
aMat = repmat(pMat, 1, n);
bMat = repmat(pMat, n, 1);
bMat = reshape(bMat, k, n * n);
dMat = aMat - bMat;
dMat = dot(dMat, dMat);
dMat = sqrt(dMat);
dMat = reshape(dMat, n, n)
%% TASK 8
n = input('Input number');
binMat = dec2bin(0:2^n - 1)
%%  TASK 9  
maxSize = 100;
clear timeSpend;
clear timeExpected;
for n = 1:maxSize
    aMat = rndi(100, n, n);
    bMat = rndi(100, n, n);
    tic;
    cMat = my_multiply(aMat, bMat);
    timeSpend(n) = toc;
    tic;
    cMat = aMat * bMat;
    timeExpected(n) = toc;
end
x = 1:maxSize;
figure
hold on
xlabel('Matrix Size');
ylabel('Time (seconds)');
plot(x, timeSpend, '-b', x, timeExpected, '-r');
grid on;
legend('My multiply time', 'Matlab multiply time');
%% TASK 10
aMat = [NaN, 3, 5; NaN, 18, 7; NaN, 6, NaN]
aSize = size(aMat);
count = aSize(1) - sum(isnan(aMat));
ans = sum(aMat, 'omitnan') ./ count
%% TASK 11
aNum = 1
sigmaNum = 5
n = 200
aVec = sigmaNum * randn(n) + aNum;
disp('Percentage of elements, that are in three sigmas range: ');
isInMat = abs(aVec - aNum) <= 3 * sigmaNum;
isInNum = sum(isInMat(:) == 1);
isInNum / numel(aVec) * 100
%% TASK 12
n = 0.001;
m = 4 * pi;
step = 0.1;
k = 0.01:0.001:1.5;
kSize = numel(k);
rectError = zeros(1, kSize);
simpsError = zeros(1, kSize);
rectTime = zeros(1, kSize);
simpsTime = zeros(1, kSize);
for i = 1:kSize
    %here we calculate inner error
    xVec = n:(k(i) ./ 2):m; % h/2
    yVec = sin(xVec) ./ xVec;
    x1Vec= n:k(i):m;
    y1Vec = sin(x1Vec) ./ x1Vec;
    tic;
    rectH = rectangles(xVec, yVec);
    rectTime(1, i) = toc;
    rectError(1, i) = abs(rectH ...
        - rectangles(x1Vec, y1Vec));
    xSize = size(xVec, 2);
    x1Size = size(x1Vec, 2);
    if (mod(xSize, 2) == 0)
        yVec = yVec(1:xSize - 1);
    end
    if (mod(x1Size, 2) == 0)
        y1Vec = y1Vec(1:x1Size - 1);
    end
    xVec = xVec(1:2:xSize);
    x1Vec = x1Vec(1:2:x1Size);
    tic;
    simpsH = simpson(xVec, yVec);
    simpsTime(1, i) = toc;
    simpsError(1, i) = abs(simpsH ...
        - simpson(x1Vec, y1Vec));
end;
% now we calculate primitive
clear xVec yVec x1Vec y1Vec xSize;
xVec = n:step:m;
x1Vec = n:(step ./ 2):m;
xSize = numel(xVec);
rectInt = zeros(1, xSize);
simpInt = zeros(1, xSize);
for i = 2:xSize
    yVec = sin(xVec) ./ xVec;
    rectInt(1, i) = rectangles(xVec(1:i), yVec(1:i));
    y1Vec = sin(x1Vec) ./ x1Vec;
    simpInt(1, i) = simpson(xVec(1:i), y1Vec(1:(2 * i) - 1));
end
figure;

s(1) = subplot(2, 1, 1);
hold on;
grid on;
xlabel('X');
ylabel('Y');
title(s(1), 'Approx. Primitive');
plot(s(1), xVec, rectInt, '-b');
plot(s(1), xVec, simpInt, '-r');
legend(s(1), 'Rectangles primitive', 'Simpson primitive');

s(2) = subplot(2, 1, 2);
hold on;
grid on;
xlabel('H');
ylabel('Error');
title(s(2), 'Errors');
plot(s(2), k, rectError, '-b');
plot(s(2), k, simpsError, '-r');
legend(s(2), 'Rectangles inner error', 'Simpson inner error');

% s(3) = subplot(3, 1, 3);
% title(s(3), 'Time');
% loglog(s(3), k, simpsTime, '-b');
% hold on;
% grid on;
% xlabel('H');
% ylabel('Time');
% loglog(s(3), k, rectTime, '-r');
% legend(s(3), 'Rectangles time',  'Simpson time');

%%  TASK 13
%function = x*cos(x)
%exact derivative = -x*sin(x) + cos(x)
%derivatives at 2/3 pi with different steps
step = 0.5:-0.001:0.000001;
dot = 2 / 3 * pi;
right = (step + dot);
left = (dot - step);
rightDer = ((right .* cos(right)) - (dot .* cos(dot))) ./ step;
centreDer = ((right .* cos(right)) - (left .* cos(left))) ./ (2 * step);
exactDer = - dot * sin(dot) + cos(dot);
figure;
loglog(step, abs(exactDer - centreDer), '-r');
hold on;
grid on;
xlabel('Step');
ylabel('Y');
loglog(step, abs(exactDer - rightDer), '-b');
legend('Derivative - center approx.', 'Derivative - right approx.');
