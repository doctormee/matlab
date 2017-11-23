function dydt = Saddle(t, y)
    dydt = [4 * y(1) - 2 * y(2); -3 * y(2)]; 
end

