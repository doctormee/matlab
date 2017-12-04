function [ res ] = func1( t )
%func1 exp(-2 * abs(t)) * cos(t)
    res = exp(-2 .* abs(t)) .* cos(t);
end