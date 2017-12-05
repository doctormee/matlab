function [ res ] = ftfunc2( t )
%ftfunc1
    res = -2i.* atan(t) + 1i.*pi*sign(t);
end