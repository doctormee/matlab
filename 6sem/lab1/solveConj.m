function [ tMaj, tRet, xMaj, psi0Maj, alphaMaj, xSusp ] = solveConj( tMaj, A, f, p, P, ...
    x0, t0, T, leftAlpha, rightAlpha, gridsize, opts, print )
%This function tries to solve the system in all directions 
%%using Pontraygin Maximum Principle
    tMaj = inf;
    tRet = [];
    xMaj = [0, 0];
    psi0Maj = [0, 0];
    alphaMaj = 0;
    alphaSpace = linspace(leftAlpha, rightAlpha, gridsize);
    xSusp = [];
    i = 1;
    for alpha = alphaSpace
        psi0 = [sin(alpha); cos(alpha)];
        psi = @(t) expm(-A.' .* (t - t0)) * psi0;
        u = @(t) p + (P * psi(t)) ./ (sqrt(dot(psi(t), P * psi(t))));
        [t, x, te, xe, ie] = ode45(@(t, x) A * x + u(t) + f, [t0, T + t0], x0, opts);
        if (~isempty(te))
            if (print)
                xSusp{i} = x;
                i = i + 1;
%                 plot(x(:, 1), x(:, 2), 'g', 'DisplayName', 'Suspiscious trajectory');
%                 hold on;
            end
            if (te < tMaj)
                tRet = t;
                tMaj = te;
                xMaj = x;
                psi0Maj = psi0;
                alphaMaj = alpha;
            end
        end
    end
end

