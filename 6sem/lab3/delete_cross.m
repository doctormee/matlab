function [X, Y] = delete_cross(Xinput, Yinput)

X = Xinput;
Y = Yinput;
isBorder = true;
prevCross = [0 0;0 0];
i = 1;
while i < length(X)
    
    x1 = X(i);
    y1 = Y(i);
    
    x2 = X(i + 1);
    y2 = Y(i + 1);
    
    j = i + 2;
    while j < length(X)
        
        if i == prevCross(2, 1)
            if ~isBorder
                X = [X(1:prevCross(1, 1)), prevCross(1, 2), X(j + 1 : end)];
                Y = [Y(1:prevCross(1, 1)), prevCross(2, 2), Y(j + 1 : end)];
                isBorder = true;
                break;
            end
        end
        
        x3 = X(j);
        y3 = Y(j);
        x4 = X(j + 1);
        y4 = Y(j + 1);
        
        [isCr, point] = is_crossing(x1, x2, x3, x4, y1, y2, y3, y4);
        if (isCr && (sum(~isnan(point))))
            if isBorder
                prevCross = [[i; j], point];
            else
                X = [X(1 : prevCross(1, 1)), prevCross(1, 2), NaN, point(1),...
                    X(i + 1 : j), point(1), NaN, prevCross(1, 2),...
                    X((prevCross(2, 1) + 1) : end)];
                Y = [Y(1 : prevCross(1, 1)), prevCross(2, 2), NaN, point(2),...
                    Y(i + 1 : j), point(2), NaN, prevCross(2, 2),...
                    Y(prevCross(2, 1) + 1 : end)];
                i = i + (3 - i + prevCross(1, 1));
                j = j + (3 - prevCross(2, 1) + j);
%                 X = [X(1 : j), point(1), NaN, prevCross(1, 2), X(prevCross(1, 2) + 1 : end)];
%                 Y = [Y(1 : prevCross(1, 1)), prevCross(2, 2), NaN, point(2), Y(i + 1 : end)];
%                 Y = [Y(1 : j), point(2), NaN, prevCross(2, 2), Y(prevCross(1, 2) + 1 : end)];
                prevCross = [[i; j], point];
            end
            isBorder = ~isBorder;
            break;
        end
        j = j + 1;
    end
    i = i + 1;
end

end