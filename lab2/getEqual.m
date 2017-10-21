function [ p ] = getEqual( f, g, t0, t1, N )
%getEqual 
    if (N <= 1)
        disp('Error! N must be >= 2');
        return;
    end
    p = zeros(N, 2);
    lin = zeros(N, 2);
    p(1, 1) = f(t0);
    p(1, 2) = g(t0);
    p(N, 1) = f(t1);
    p(N, 2) = g(t1);
    linT = linspace(t0, t1, N);
    lin(:, 1) = f(linT);
    lin(:, 2) = g(linT);
    size = 500;
    lsp = linspace(t0, t1, size);
    spacing = lsp(2) - lsp(1);
     if (N == 2)
        return;
    end
    fVal = f(lsp);
    gVal = g(lsp);
    fDer = fVal(3:size) - fVal(1:size - 2) ./ (2 .* spacing);
    gDer = gVal(3:size) - gVal(1:size - 2) ./ (2 .* spacing);
    dist = sqrt(fDer .^ 2 + gDer .^ 2) .* spacing;
    partVec = cumsum(dist);
    length = partVec(size - 2) ./ (N - 1);
    for i = 2:(N - 1)
        tr = find(partVec > ((i - 1) .* length), 1);
        p(i, 1) = fVal(tr + 1);
        p(i, 2) = gVal(tr + 1);
    end
    plot(p(:, 1), p(:, 2), '-r', lin(:, 1), lin(:, 2), '-b');
    xlabel('X');
    ylabel('Y');
    legend('getequal', 'linear');
%     lineSym(t) = symfun(sqrt(((fSymDer) ^ 2 + (gSymDer) ^ 2)), t);
%     length(left, right) = int(lineSym, t, left, right);
%     part = length(t0, t1) ./ (N - 1);
%     left = t0;
%     for i = 2:N - 1
%         eqn = length(left, tx) == part;
%         ans = solve(eqn, tx);
%         p(i, 1) = f(ans);
%         p(i, 2) = g(ans);
%         left = ans;
%     end
%     p(N, 1) = f(t1);
%     p(N, 2) = g(t1);
    disp('Difference: ');
    diff = norm(sum(abs(p - lin)) ./ N )
end

