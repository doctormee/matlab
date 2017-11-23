clc;
left = 0;
right = pi ./ 2;
N = 10;
solinit = bvpinit(linspace(left, right, N), [0 0]); % initial form of guessing for solution
sol = bvp4c(@fun11, @bound11, solinit); % solving boundary problem
x = linspace(left,right);
y = deval(sol,x);
anSol = @(x) 1 - cos(x) - sin(x);
plot(x,y(1,:),'.', x, anSol(x))
legend('Numerical solution', 'Analytical solution');
xlabel('x');
ylabel('y');
grid on;
disp(['Difference in L2-norm: ', num2str(trapz(x, (y(1,:) - anSol(x)).^2).^(1/2))]);
disp(['Difference in C-norm: ', num2str(max(abs((y(1,:) - anSol(x)))))]);