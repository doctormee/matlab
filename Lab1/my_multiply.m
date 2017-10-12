function [ cMat ] = my_multiply( aMat, bMat )
%MY_MULTIPLY myltiplying two matrices by definition
%   usage: c = my_multiply(A, B)
    [aRows, aCols] = size(aMat);
    [bRows, bCols] = size(bMat);
    cMat = zeros(aRows, bCols);
    if (aCols ~= bRows)
        disp('Matrices size does not match');
        cMat = 0;
        return;
    end
    for i = 1:aRows
        for j = 1:bCols
            cMat(i, j) = sum(aMat(i, :) .* bMat(:, j).');
        end
    end
end

