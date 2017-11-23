function dydt = Degenerate(t, y)
    dydt = [y(1) + y(2); 2 .* y(1) + 2 .* y(2)];
end