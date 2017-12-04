function [ res ] = func3( t )
%func1 exp(-2 * abs(t)) * cos(t)
    res = atan(t .^ 2) ./ (1 + t .^ 4);
end