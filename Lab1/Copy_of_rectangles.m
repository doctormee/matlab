function [ ansNum ] = rectangles( varargin )
%RECTANGLES Integration via rectangles method
    %usage: rectangles(Y) ? assuming spacing is 1
    %rectangles(X, Y) ? compute integral of Y in relation to X
    %rectangles(X, Y, dim) ? compute integral of Y in relation to X across
    %dimension dim
    nVarargs = length(varargin);
    if (nVarargs > 3) || (nVarargs == 0)
        disp('Incorrect number of arguments');
        return;
    end
    if (nVarargs < 3)
        dim = 2;
        if (nVarargs == 2)
            x = varargin{1};
            y = varargin{2};
        else
            y = varargin{1};
            x = 1:size(y, dim);
        end
    else
        x = varargin{1};
        y = varargin{2};
        dim = varargin{3};
    end
    xLength = size(x, dim);
    h = diff(x, 1, dim);
    yLength = size(y, dim);
    if (yLength ~= xLength)
        disp(['Y size musts be equal to X size in dim ', num2str(dim)]);
        return;
    end;
    trapz
    ansNum = sum(y(2:xLength) .* h, dim);
end

