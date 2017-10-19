%task 6
%%ONE
% f = @(x) x .* exp(x .* cos(x));
f = @(x) sin(x) + cos(x./2);    
% f = @(x) - sin(x) - cos(x./2);    
% f = @(x) 1 + x .* 0;
x = -10:0.001:10;
%%
[minVal, minInd] = findpeaks(-f(x));
minVal = -minVal;
[maxVal, maxInd] = max(f(x));
hold on;

plot(x, f(x), x(maxInd), maxVal, '*r', x(minInd), minVal, '*b');
[closestMinVal, closestMinInd] = min(abs(minInd - maxInd));
closestMinInd = minInd(closestMinInd);
grid on;
if (closestMinInd < maxInd)
    comet(wrev(x(closestMinInd : maxInd)), wrev(f(x(closestMinInd : maxInd))));
else
    comet(x(maxInd : closestMinInd), f(x(maxInd : closestMinInd)));
end;
