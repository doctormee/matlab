function [ ] = fourierApprox( f, a, b, n, meth )
% fourierApprox draws fourier expansion aprrox
    if ( a >= b ) || ~(abs(a) < inf) || ~(abs(b) < inf)
        disp('Incorrect bounds!');
        return;
    end
    size = 2500; %size of partition of [a, b]
    lsp = linspace(a, b, size); %%linear spacing
    diam = lsp(2) - lsp(1);
%     figure;
    fmin = min(f(lsp)); % minimum (for axis)
    fmax = max(f(lsp)); %maximum (for axis)
    fVec = f(lsp);
    epsilon = 1; %deviation on plot
    if (strcmp(meth, 'std')) %standard expansion
        getFunc = @(n) getFuncStd(n, a, b, lsp);
    elseif (strcmp(meth, 'wls'))
        getFunc = @(n) getFuncWalsh(n, a, b, lsp);
    elseif (strcmp(meth, 'leg'))
        getFunc = @(n) getFuncLegendre(n, a, b, lsp);
        if (n > 50)
            disp('Too much for this method!');
            return;
        end
    else
        disp('Incorrect method!');
        return;
    end
%     l = (b - a) ./ 2;
    series = zeros(1, size);
%     now we Fourier!
    for i = 0:(n - 1)
        fourVec = getFunc(i);
%         A = double(int(f(t) * fourFunc(t), t, a, b)) ./ (b - a);
        A = (dot(fVec, fourVec) .* diam) ./ ((norm(fourVec) .^ 2) .* diam);
        series = series + A .* fourVec;
        plot(lsp, series, lsp, f(lsp));
        grid on;
        axis([a b fmin - epsilon fmax + epsilon]);
        xlabel('X');
        ylabel('Y');
        title(['Step number ' num2str(i + 1) ' norm ' num2str(norm(abs(fVec - series) .* sqrt(diam)))]);
        legend('Fourier sum', 'Function');
        getframe();
    end
end

function [ f ] = getFuncStd( n, a, b, lsp )
%getFuncStd returns n-th function from standard sine-cosine Fourier system
%on [a, b]
    l = (b - a) ./ 2;
    if (mod(n, 2)) % odd
        f = sin(pi .* ( lsp .* (n + 1) ./ 2) ./ l);
    else % even
        f = cos( pi .* (lsp .* (n  ./ 2)) ./ l);
    end
end

function [ f ] = getFuncWalsh( n, a, b, lsp )
%getFuncWalsh returns n-th Walsh function
    bin = de2bi(n);
    f = ones(1, numel(lsp));
    x = (lsp - a) ./ (b - a);
    for i = 1:numel(bin)
        f = f .* sign(sin( pi .* 2 .^ i .* x)) .^ (bin(i));
    end
end

function [ f ] = getFuncLegendre( n, a, b, lsp )
%getFuncLegendre returns n-th Legendre polynomial on [a b]
    f = zeros(1, numel(lsp));
    x = 2 .* (lsp - a) ./ (b - a) - 1;
    for k = 0:n
        f = f + nchoosek(n, k) .^ 2 .* (x - 1) .^ (n - k) ...
            .* (x + 1) .^ k;
    end
    f = f .* (2 .^ (-n));
end

% function [ f ] = getFuncLaguerre( n, a, b )
%getFuncLaguerre returns n-th Laguerre polynomial on [a b]
%     f = @(x) 0;
%     
% end

% function [ n ] = scalarL2( f, g, a, b )
% %funcNorm calculates scalar multiplication of f and g from a to b
%     size = 1000;
%     x = linspace(a, b, size);
%     n = dot(f(x), g(x));
% end

% function [ n ] = funcNorm( f, a, b )
% %funcNorm calculates func norm of f(in L2)
%     n = scalarL2(f, f, a, b);
% end




