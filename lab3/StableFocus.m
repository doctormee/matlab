function dydt = StableFocus(t, y)
    dydt = [-2 * y(2); y(1) - y(2)];
end


