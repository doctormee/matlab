function [ p ] = getEqual( f, g, t0, t1, N )
%getEqual 
    p = zeros(N, 2);
    lin = zeros(N, 2);
    p(1, 1) = f(t0);
    p(1, 2) = g(t0);
    linT = linspace(t0, t1, N);
    lin(:, 1) = f(linT);
    lin(:, 2) = g(linT);
    syms t;
%     fSymDer(t) = diff(f(t));
%     gSymDer(t) = diff(g(t));
    fSymDer = diff(sym(f));
    gSymDer = diff(sym(g));
%     fDer = matlabFunction(fSymDer, 'Vars', 't');
%     gDer = matlabFunction(gSymDer, 'Vars', 't');
    syms tx;
    syms left;
    syms right;
    lineSym(t) = symfun(sqrt(((fSymDer) ^ 2 + (gSymDer) ^ 2)), t);
    length(left, right) = int(lineSym, t, left, right);
    part = length(t0, t1) ./ (N - 1);
    left = t0;
    for i = 2:N - 1
        eqn = length(left, tx) == part;
        ans = solve(eqn, tx);
        p(i, 1) = f(ans);
        p(i, 2) = g(ans);
        left = ans;
    end
    p(N, 1) = f(t1);
    p(N, 2) = g(t1);
    disp('Difference: ');
    dist = norm(sum(abs(p - lin)) ./ N )
end

