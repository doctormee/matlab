function dydt = t10f(~, y)
    dydt = [y(2) - y(1) + y(1) .* y(2); y(1) .* (1 - y(1)) + y(2) .* (1 - y(2) .^ 2)];
end