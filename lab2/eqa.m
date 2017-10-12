N = 5;
t0 = 0;
tN = 2*pi;
syms t;
f = sin(t);
g = cos(t);
l = int((diff(f).^2 + diff(g).^2).^(1./2), t0, tN);
tA = zeros(1, N + 1);
tA(1, 1) = t0;
space = (l.^2) ./ (N .^ 2);
for i = 2:N
    tA(1, i) = solve((((f(tA(1, i - 1)) - f(t)) .^ 2 + (g(tA(1, i - 1)) - g(t)) .^ 2 ) == space), t);
end
