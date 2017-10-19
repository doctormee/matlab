function [ f ] = pointsup( a, b )
%returns support function of (a, b);
    function [Val, Point] = rho(l)
        Point = [a, b];
        Val = dot(Point, l);
    end;
    f = @rho;
end

