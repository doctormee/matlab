function [value, isterminal, direction] = fuel_left(t, y, M )
    moe = 10e-1;    
    value = [int8(abs(y(2) - M) > moe)];
    isterminal = [1];
    direction = [0];
end

