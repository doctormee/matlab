function [ res ] = func2( t )
%func1 exp(-2 * abs(t)) * cos(t)
    res = (exp(-1 .* abs(t)) - 1) ./ t ;
end