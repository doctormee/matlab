%% numero trois
squares = @(x) 1./ (x .^ 2) ;
s = zeta(2);
N = 1:1000;
sqn = squares(N);
sn = cumsum(sqn);
plot(N, sn - s);
hold on;
psi = @(n) 1./n; %from the fact that Σ(1./n.^2) <= Σ(1./n(n - 1))
plot(N, psi(N));
grid on;
legend('sn - s', 'psi');
find((abs(sn - s) > psi(N)))
