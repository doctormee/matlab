function [ res ] = uAnalytical( xMat, yMat, mju, u1Zero, u2Zero )
    syms u1(x);
    syms u2(y);
    f1 = @(x) 3.*(x.^3).*exp(x).*cos(x);
    f2 = @(y)  + y.*sin(4.*y) - cos(y);
    part1 = matlabFunction(dsolve(diff(u1, 2) - mju*u1 == f1, ...
        u1(0) == u1Zero, u1(1) == u1Zero));
    part2 = matlabFunction(dsolve(diff(u2, 2) - mju*u2 == f2, ...
        u2(0) == u2Zero, u2(1) == u2Zero));
    res = part1(xMat) + part2(yMat);
end

