function [ position, isterminal, direction ] = in_set(t, x, a, b, c, x11, x12, moe )
%checks whether x is in set X1
    position = int8(~(a * (x(1) - x11) .^ 2 + b * abs(x(2) - x12) - c ...
        < moe));
    isterminal = 1;
    direction = 0;
end


