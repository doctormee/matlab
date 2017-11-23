function dydt = StableNode(t, y)
    dydt = [-y(1); 2 * y(1) - 2 * y(2)];
end

