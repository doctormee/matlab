function [answer, point] = is_crossing(x1, x2, x3, x4, y1, y2, y3, y4)

gamma = (x1*y3 - x3*y1 - x1*y4 + x4*y1 + x3*y4 - x4*y3)/ ...
    (x1*y3 - x3*y1 - x1*y4 - x2*y3 + x3*y2 + x4*y1 + x2*y4 - x4*y2);

xCur = x1 + gamma * (x2 - x1);
yCur = y1 + gamma * (y2 - y1);

answer = (min(x1 , x2)<= xCur && xCur <= max(x1, x2) && min(x3, x4) <= xCur ...
    && xCur <= max(x3, x4) && min(y1 , y2)<= yCur && yCur <= max(y2, y1) && ...
    min(y3, y4) <= yCur && yCur <= max(y3,y4));
if answer
    point = [xCur; yCur];
else
    if isnan(gamma)
        answer = true;
    end
    point = NaN;
end
end