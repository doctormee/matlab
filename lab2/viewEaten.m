function [ ] = viewEaten( points, L, p )
    N = size(points, 1);
    left = min(points, 2) - L;
    xLeft = left(1);
    yLeft = left(2);
    right = max(points, 2) + L;
    xRight = right(1);
    yright = right(2);
end