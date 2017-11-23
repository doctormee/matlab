function dydt = StableDegenerateNode(t, y)
    dydt = [-3 * y(1) + 2 * y(2); y(2) - 2 * y(1)];
end

