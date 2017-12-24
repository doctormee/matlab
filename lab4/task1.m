clear;
u1Zero = 10;
u2Zero = 1;
M = 10;
N = 50;
mju = 2;
x = linspace(0, 1, M);
xStep = 1 ./ M;
y = linspace(0, 1, N);
yStep = 1 ./ N;
[yGrid, xGrid] = meshgrid(y, x);

mat = real(uNumerical(u1Zero, u2Zero, mju, M, N));
anaMat = uAnalytical(xGrid, yGrid, mju, u1Zero, u2Zero);

numSurface = surf(xGrid, yGrid, mat);
set(numSurface,'FaceColor',[1 0 0],'FaceAlpha',1);
hold on;
anaSurface = surf( xGrid, yGrid, anaMat);
set(anaSurface,'FaceColor',[0 1 0],'FaceAlpha',0.5);
legend('Numerical', 'Analyical');
title('Solutions');
xlabel('X');
ylabel('Y');
zlabel('U(x, y)');

figure;
surf( xGrid, yGrid, abs(anaMat - mat));
title('Absolute difference between numerical and analytical solutions');
xlabel('X');
ylabel('Y');
zlabel('Difference');