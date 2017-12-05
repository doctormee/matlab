function [ res ] = ftfunc1( t )
%ftfunc1
    res = 4 .* (t.^2 + 5) ./ (t.^4 + 6 .* t.^2 + 25);
end