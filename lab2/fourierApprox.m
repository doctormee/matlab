function [ ] = fourierApprox( f, a, b, n, meth )
% fourierApprox draws fourier expansion aprrox
    if ( a >= b ) || ~(abs(a) < inf) || ~(abs(b) < inf)
        disp('Incorrect bounds!');
        return;
    end
    size = 1000; %size of partition of [a, b]
    lsp = linspace(a, b, size); %%linear spacing
%     figure;
    fmin = min(f(lsp)); % minimum (for axis)
    fmax = max(f(lsp)); %maximum (for axis)
    epsilon = 1; %deviation on plot
    if (strcmp(meth, 'std')) %standard expansion
        getFunc = @(n) getFuncStd(n, a, b);
    elseif (strcmp(meth, 'wls'))
        getFunc = @(n) getFuncWalsh(n, a, b);
    elseif (strcmp(meth, 'leg'))
        getFunc = @(n) getFuncLegendre(n, a, b);
    else
        disp('Incorrect method!');
        return;
    end
    l = (b - a) ./ 2;
    series = @(x) 0;
%     now we Fourier!
    for i = 0:(n - 1)
        fourFunc = getFunc(i);
        syms t;
%         A = double(int(f(t) * fourFunc(t), t, a, b)) ./ (b - a);
        A = scalarL2(f, fourFunc, a, b) ./ funcNorm(fourFunc, a, b);
        series = @(x) series(x) + A .* fourFunc(x);
        plot(lsp, series(lsp), lsp, f(lsp));

        grid on;
        axis([a b fmin - epsilon fmax + epsilon]);
        xlabel('X');
        ylabel('Y');
        title(['Step number ' num2str(i + 1)]);
        legend('Fourier sum', 'Function');
        getframe();
    end
end
% function [ ] = fourierApprox( f, a, b, n, meth )
% %fourierApprox draws fourier expansion aprrox
%     size = 1000; %partition of [a, b]
%     lsp = linspace(a, b, size);
%     if (strcmp(meth, 'std')) %standard expansion
%         getFunc = @(x) getFuncStd(x, a, b);
%         series = @(x) 0;
%         l = (b - a) / 2;
%         syms x;
%         for i = 1:n
%             fourFunc = getFunc(i);
%             A = double(int(f(x) .* fourFunc(x),x, a, b) ./ l);
%             if (i == 1)
%                 A = A ./ 2;
%             end
%             series = @(x) series(x) + A .* fourFunc(x);
%             plot(lsp, series(lsp));
%             xlabel('X');
%             ylabel('Y');
%             title(['Step number ' num2str(i)]);
%             getframe();
%         end
%     elseif (strcmp(meth, 'wls'))
% %             getFunc = @(x) getFuncWalsh(x);
%     elseif (strcmp(meth, 'lag'))
%         getFunc = @(x) getFuncLaguerre(x);
%         weight = @(x) exp(-x);
%     end
% end

function [ f ] = getFuncStd( n, a, b )
%getFuncStd returns n-th function from standard sine-cosine Fourier system
%on [a, b]
    l = (b - a) ./ 2;
    if (n == 0)
        f = @(x) 1;
    else
        if (mod(n, 2)) % odd
            f = @(x) sin( (n + 1 ./ 2) .* x);
        else % even
            f = @(x) cos( (n  ./ 2) .* x);
        end
    end
    f = @(x) f(pi .* x ./ l);
end

function [ f ] = getFuncWalsh( n, a, b )
%getFuncWalsh returns n-th Walsh function
    bin = de2bi(n);
    f = @(x) 1;
    for i = 1:numel(bin)
        f = @(x) f(x) .* sign(sin( pi .* 2 .^ i .* x)) .^ (bin(i));
    end
    f = @(x) f((x - a) ./ (b - a));
end

function [ f ] = getFuncLegendre( n, a, b )
%getFuncLegendre returns n-th Legendre polynomial on [a b]
    f = @(x) 0;
    for k = 0:n
        f = @(x) f(x) + nchoosek(n, k) .^ 2 .* (x - 1) .^ (n - k) ...
            .* (x + 1) .^ k;
    end
    f = @(x) f(x) .* (2 .^ (-n));
    f = @(x) f(2 .* (x - a) ./ (b - a) - 1);
end

% function [ f ] = getFuncLaguerre( n, a, b )
%getFuncLaguerre returns n-th Laguerre polynomial on [a b]
%     f = @(x) 0;
%     
% end

function [ n ] = scalarL2( f, g, a, b )
%funcNorm calculates scalar multiplication of f and g from a to b
    syms x;
    f = symfun(f(x), x);
    g = symfun(g(x), x);
    n = double(int((f * g), x, a, b));
end

function [ n ] = funcNorm( f, a, b )
%funcNorm calculates func norm of f(in L2)
    n = scalarL2(f, f, a, b);
end




