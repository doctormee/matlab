%%
a = -10;
b = 10;
size = 100;
x = linspace(a, b, size);
xx = linspace(a, b, 2 * size);
%%
f = @(x) sign(2 .* x);
F = f(xx);
fDerMax = 2;
apriori = fDerMax * (b - a) ./ (2 .* size);
apriori = apriori * ones(1, numel(xx));
nearF = interp1(x, f(x), xx, 'nearest');
plot(xx, apriori, '-r', xx, abs((nearF - F)), '-b');
legend('apriori', 'aposteriori');
grid on;
xlabel('x');
ylabel('y');
hold on;
%%
f = @(x) 3.* x .^ 2;
F = f(xx);
fDerMax = 6 .* b;
apriori = fDerMax * (b - a) ./ (2 .* size);
apriori = apriori * ones(1, numel(xx));
nearF = interp1(x, f(x), xx, 'nearest');
grid on;
hold on;
plot(xx, apriori, '-r', xx, abs((nearF - F)), '-b');
xlabel('x');
ylabel('y');
legend('apriori', 'aposteriori');
