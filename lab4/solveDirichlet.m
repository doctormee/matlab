function [ res ] = solveDirichlet( fHandle, xiHandle, etaHandle, mu, M, N )
    x = linspace(0, 1, M);
    xStep = 1 ./ M;
    y = linspace(0, 1, N);
    yStep = 1 ./ N;
    n = 1:N;
    m = 1:M;
    theta = @(k, l) 1 ./ ((-4 ./ xStep.^2) .* sin(pi .* (k - 1) ./ M) .^2 + ...
        (-4 ./ yStep.^2) .* sin(pi .* (l - 1) ./ N) .^2 - mu);
    phi = zeros(M, N);
    [yGrid, xGrid] = meshgrid(y(2:end), x(2:end));
    [nGrid, mGrid] = meshgrid(n, m);
    Theta = theta(mGrid, nGrid);
    phi(2:end, 2:end) = fHandle(xGrid, yGrid); %now we know all phies, except first ones
    Phi0 = fft2(phi);
    %here we try to find phi(0, i), phi (i, 0) and phi(0, 0) via solving a
    %SLAE:
    %this would be useful later on:
    indicesM = repmat([1:M], M, 1);
    indicesM = abs(indicesM - indicesM.') + 1;
    indicesN = repmat([1:N-1], N - 1, 1);
    indicesN = abs(indicesN - indicesN.') + 1;
    thetaIfft2 = ifft2(Theta);
    thetaFft2 = fft2(Theta);
    firstColI = thetaIfft2(:, 1);
    firstCol = thetaFft2(:, 1);
    firstRowI = thetaIfft2(1, :);
    firstRow = thetaFft2(1, :);
    A12 = ifft(fft(Theta, [], 2), [], 1);
    A12 = A12(2:end, :) .* (1 ./ N);
    A21 = ifft(fft(Theta, [], 1), [], 2);
    A21 = A21(:, 2:end).' .* (1 ./ M);
    
end

