function [ xl, xr, yl, yr ] = getBorders( x0, x11, x12, a, b, c )
    xl = min([x0(1), x11 - sqrt(c ./ a)]);
    xr = max([x0(1), x11 + sqrt(c ./ a)]);
    yl = min([x0(2),  x12 - c ./ b]);
    yr = max([x0(2),  x12 + c ./ b]);
end

