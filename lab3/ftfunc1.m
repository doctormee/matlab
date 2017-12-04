function [ res ] = ftfunc1( t )
%ftfunc1
    res = (2 .* sqrt(2) ./ sqrt(pi)) .* (t.^2 + 5) ./ (t.^4 + 6 .* t.^2 + 25);
end