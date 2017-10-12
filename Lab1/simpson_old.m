function [ ansNum ] = simpson( xVec, yVec )
%Simpson Integration via Simpson method
    % Assuming that xVec is linearly spaced
    xLength = numel(xVec);
    h = (xVec(1, xLength) - xVec(1,1) )./ xLength;
    yLength = length(yVec);
    if (yLength ~= xLength)
        disp('Y size musts be equal to X size');
        return;
    end;
    ansNum = (yVec(1, 1) + 4 * sum(yVec(1, 2:2:xLength)) + 2 * sum(yVec(3:2:xLength)) + yVec(yLength)) * (h ./ 3);
end

