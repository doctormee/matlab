%constants
numGraph = 5;
moe = 1e-3;
scaleX = 5;
scaleP = 1;
numOfSteps = 1000;
lspX = linspace((x0(1) - scaleX), x0(1) + scaleX, numOfSteps);
lspY = linspace((x0(2) - scaleX), x0(2) + scaleX, numOfSteps);
[X, Y] = meshgrid(lspX, lspY);
lspUX = linspace((p(1) - scaleP), p(1) + scaleP, numOfSteps);
lspUY = linspace((p(2) - scaleP), p(2) + scaleP, numOfSteps);
[UX, UY] = meshgrid(lspUX, lspUY);
if (~exist('gridsize', 'var') || isnumeric(gridsize) && (gridsize <= 0))
    gridsize = 100;
end
P = [r ./ 9, 0; 0, r ./ 4];
setx1 = @(x, y) a * (x - x11) .^ 2 + b * abs(y - x12);
eventFcn = @(t, x) in_set(t, x, a, b, c, x11, x12, moe);
opts = odeset('Events', eventFcn);
setP = @(x, y) 9 .* (x - p(1)).^2 + 4 .* (y - p(2)).^2;


%already in?
if (~in_set(0, x0, a, b, c, x11, x12, moe))
    disp('Already in X1');
    return;
end

%main part
figTraj = figure();
%solving with print
[ tmaj, t, xmaj, psi0maj, alphaMaj ] = solveConj(inf, A, f, p, P, x0, t0,...
    T, 0, 2 .* pi, gridsize, opts, 1, figTraj);
% %or without
% [ tmaj, t, xmaj, psi0maj, alphaMaj ] = solveConj(inf, A, f, p, P, x0, t0,...
%     T, 0, 2 .* pi, gridsize, opts, 0, []);
% plotting
plot(xmaj(:, 1), xmaj(:, 2), 'b', 'DisplayName', 'Optimal trajectory');
grid on;
hold on;
%plotting the set
contour(X, Y, setx1(X, Y), [c c], ...
    'DisplayName', 'Set X_{1}', 'color', 'k');
%now we need psimaj
psimaj = @(t) expm(-A.' .* (t - t0)) * psi0maj;
%check if solved
if (tmaj == inf)
    disp('No solution!');
    return
end
disp(['Optimal time: ', num2str(tmaj)]);

%measuring error
disp(['Error: ', num2str(calcError(a, b, c, x11, x12, xmaj(end, :), ...
    psimaj, t, moe))]);
%%now let us try to improve locally:
[ tmajNew, t, xmajNew, psi0majNew, alphaMajNew ] = ...
    solveConj(tmaj, A, f, p, P, x0, t0,...
    T, alphaMaj .* 0.9, alphaMaj .* 1.1, gridsize ./ 2, opts, 0, []);
figure(figTraj);
plot(xmajNew(:, 1), xmajNew(:, 2), 'r', ...
    'DisplayName', 'Improved optimal trajectory');
grid on;
hold on;
psimaj = @(t) expm(-A.' .* (t - t0)) * psi0majNew;
psi1 = -psimaj(t(end)) ./ norm(psimaj(t(end)));
%we plot -psi(t1)
quiver(xmajNew(end, 1), xmajNew(end, 2), psi1(1), psi1(2), ...
    'DisplayName', '-\Psi(t_1)');
[err, n] = calcError(a, b, c, x11, x12, xmajNew(end, :), psimaj, t, moe);
%normale vector
n = n ./ norm(n);
%plotting it too
quiver(xmajNew(end, 1), xmajNew(end, 2), n(1), n(2), ...
    'DisplayName', 'normal', 'Color', 'r');
%checking whether we have suspiscious trajectories
h = get(gca, 'children');
if (numel(h) > numGraph)
    h = [h(1:numGraph); h(end)];
end
%and putting on good legend and title etc.
legend(h);
title('Trajectories');
xlabel('x_1');
ylabel('x_2');
disp(['Improved optimal time: ', num2str(tmajNew)]);
disp(['Error: ', num2str(err)]);
    
%% plotting improved trajectory
figTrajMaj = figure();
p1 = subplot(2, 1, 1);
p2 = subplot(2, 1, 2);
plot(p1, t, xmajNew(:, 1), 'r', 'DisplayName', 'x_1');
hold on;
legend(p1, 'show');
grid(p1, 'on');
title(p1, 'Trajectory');
xlabel(p1, 't');
ylabel(p1, 'x_1');
plot(p2, t, xmajNew(:, 2), 'b', 'DisplayName', 'x_2');
legend(p2, 'show');
grid on;
title(p2, 'Trajectory');
xlabel(p2, 't');
ylabel(p2, 'x_2');
%% plotting U(t)
%obtaining U 
umaj = @(t) p + (P * psimaj(t)) ./ (sqrt(dot(psimaj(t), P * psimaj(t))));
uGrid = gridFunc(t, umaj);

figU1 = figure();
p1 = subplot(2, 1, 1);
p2 = subplot(2, 1, 2);
plot(p1, t, uGrid(:, 1), 'r', 'DisplayName', 'u_1');
hold on;
legend(p1, 'show');
grid(p1, 'on');
title(p1, 'Control');
xlabel(p1, 't');
ylabel(p1, 'u_1');
plot(p2, t, uGrid(:, 2), 'b', 'DisplayName', 'u_2');
legend(p2, 'show');
grid on;
title(p2, 'Control');
xlabel(p2, 't');
ylabel(p2, 'u_2');
%% Plot P and Opt Control
figU3 = figure();
contour(UX, UY, setP(UX, UY), [r r], 'DisplayName', 'set P');
hold on;
plot(uGrid(:, 1), uGrid(:, 2), 'r*', 'DisplayName', 'Optimal Control');
grid on;
legend show;
title('Control on set');
xlabel('u_1');
ylabel('u_2');
