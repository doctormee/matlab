function [ min_val, min_point, steps ] = graddesc( func, grad, x0 )
%graddesc finds minimal value of func w/ gradient grad via gradient descend
%method starting at x0
moe = 10E-7;
dim = size(x0);
lambda = 1;
steps(:, 1) = x0;
lambda = 1;
steps(:, 2) = x0 - lambda * grad(x0);
j = 2;
x_cur = steps(:, 2);
x_prev = x0;
while (norm(grad(x_cur), 2) > moe)
    x_cur = steps(:, j);
    x_prev = steps(:, j - 1);
    lambda = ((x_cur - x_prev) .' * (grad(x_cur) - grad(x_prev))) ./ ...
        dot((grad(x_cur) - grad(x_prev)), (grad(x_cur) - grad(x_prev)));
    steps(:, j + 1) = x_cur - lambda .* grad(x_cur);
    j = j + 1;
    x_cur = steps(:, j);
end
min_point = steps(:, j);
min_val = func(min_point);
end

