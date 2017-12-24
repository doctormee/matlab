function [ res ] = fGiven( x, y )
    res = 3.*(x.^3).*exp(x).*cos(x) + y.*sin(4.*y) - cos(y);
end

