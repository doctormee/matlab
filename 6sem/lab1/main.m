% constants
timesImprov = 1;
numGraph = 6;
isPrint = 0;
moeSet = 1e-10;
moeNorm = 5e-2;
moeAlpha = pi ./ 10;
scaleX = 1000;
scaleP = 1;
numOfSteps = 1000;
margin = 1;
% lspX = linspace((x0(1) - scaleX), x0(1) + scaleX, numOfSteps);
% lspY = linspace((x0(2) - scaleX), x0(2) + scaleX, numOfSteps);
% [X, Y] = meshgrid(lspX, lspY);
lspUX = linspace((p(1) - scaleP), p(1) + scaleP, numOfSteps);
lspUY = linspace((p(2) - scaleP), p(2) + scaleP, numOfSteps);
[UX, UY] = meshgrid(lspUX, lspUY);
if (~exist('gridsize', 'var') || isnumeric(gridsize) && (gridsize <= 0))
    gridsize = 100;
end
P = [r ./ 9, 0; 0, r ./ 4];
setx1 = @(x, y) a * (x - x11) .^ 2 + b * abs(y - x12);
eventFcn = @(t, x) in_set(t, x, a, b, c, x11, x12, moeSet);
opts = odeset('Events', eventFcn);
setP = @(x, y) 9 .* (x - p(1)).^2 + 4 .* (y - p(2)).^2;


%already in?
if (~in_set(0, x0, a, b, c, x11, x12, moeSet))
    disp('Already in X1');
    return;
end

%main part
%solving 
alphaSpace = linspace(0, 2.*pi, gridsize);
[ tmaj, t, xmaj, psi0maj, alphaMaj, xSusp ] = solveConj(inf, A, f, p, P, x0, t0,...
    T, alphaSpace, opts);
%check if solved
if (tmaj == inf)
    disp('No solution!');
    return
end
disp(['Optimal time: ', num2str(tmaj)]);
%now we need psimaj
psimaj = @(t) expm(-A.' .* (t - t0)) * psi0maj;
%measuring error
disp(['Error: ', num2str(calcError(a, b, c, x11, x12, xmaj(end, :), ...
    psimaj, t, moeNorm))]);
xmajOld = xmaj;
%improving the result
for j = 1:timesImprov
%now let us try to improve locally:
    alphaSpace = [linspace(alphaMaj - moeAlpha, alphaMaj + moeAlpha, ...
        gridsize ./ 2), alphaMaj];
    [ tmajNew, tNew, xmajNew, psi0majNew, alphaMajNew,  ] = ...
        solveConj(tmaj, A, f, p, P, x0, t0,...
        T, alphaSpace, opts);

% %improving globally
%     alphaSpace = linspace(0, 2.*pi, (j + 1) .* gridsize);
% [ tmajNew, tNew, xmajNew, psi0majNew, alphaMajNew, xSuspNew  ] = ...
%     solveConj(tmaj, A, f, p, P, x0, t0,...
%     T, alphaSpace, opts);
    if (tmajNew == tmaj)
        disp('Can not improve any further');
        disp(['Final optimal time: ', num2str(tmaj)]);
        [err, n] = calcError(a, b, c, x11, x12,...
            xmaj(end, :), psimaj, t, moeNorm);
        disp(['Error: ', num2str(err)]);
        break;
    else
        tmaj = tmajNew;
        t = tNew;
        xmaj = xmajNew;
        psi0maj = psi0majNew;
        alphaMaj = alphaMajNew;
    end
    psimaj = @(t) expm(-A.' .* (t - t0)) * psi0maj;
    psi1 = -psimaj(t(end)) ./ norm(psimaj(t(end)));
    disp(['Improved optimal time: ', num2str(tmaj)]);
    [err, n] = calcError(a, b, c, x11, x12,...
        xmaj(end, :), psimaj, t, moeNorm);
    disp(['Error: ', num2str(err)]);
end
psimaj = @(t) expm(-A.' .* (t - t0)) * psi0maj;
psi1 = -psimaj(t(end)) ./ norm(psimaj(t(end)));
[err, n] = calcError(a, b, c, x11, x12,...
        xmaj(end, :), psimaj, t, moeNorm);
%% plotting only test trajectories
[xl, xr, yl, yr] = getBorders(x0, x11, x12, a, b, c);
lspX = linspace(xl - margin, xr + margin, scaleX);
lspY = linspace(yl - margin, yr + margin, scaleX);
[X, Y] = meshgrid(lspX, lspY);
figTraj = figure();
for i = 1:1:numel(xSusp)
    plot(xSusp{i}(:, 1), xSusp{i}(:, 2), 'g', 'DisplayName', 'Test Trajectories');
    hold on;
end
grid on;
grid minor;
hold on;
%plotting the set
contour(X, Y, setx1(X, Y), [c c], ...
    'DisplayName', 'Set X_{1}', 'color', 'k');
h = get(gca, 'children');
h = [h(1); h(end)];
legend(h);
xlabel('x_1');
ylabel('x_2');
title('Test trajectories');
%% plotting set
setx1 = @(x, y) a * (x - x11) .^ 2 + b * abs(y - x12);
[xl, xr, yl, yr] = getBorders(x0, x11, x12, a, b, c);
lspX = linspace(xl - margin, xr + margin, scaleX);
lspY = linspace(yl - margin, yr + margin, scaleX);
[X, Y] = meshgrid(lspX, lspY);
figure();
contour(X, Y, setx1(X, Y), [c c], ...
    'DisplayName', 'Set X_{1}', 'color', 'k');
hold on;
plot(x0(1), x0(2), 'r*', 'DisplayName', 'Set X_{0}');
grid on;
grid minor;
legend show;
%% plotting
%getting borders
[xl, xr, yl, yr] = getBorders(x0, x11, x12, a, b, c);
lspX = linspace(xl - margin, xr + margin, scaleX);
lspY = linspace(yl - margin, yr + margin, scaleX);
[X, Y] = meshgrid(lspX, lspY);
figTraj = figure();
if (isPrint == 1)
    for i = 1:1:numel(xSusp)
        plot(xSusp{i}(:, 1), xSusp{i}(:, 2), 'g', 'DisplayName', 'Suspiscious Trajectories');
        hold on;
    end
end
plot(xmajOld(:, 1), xmajOld(:, 2), 'b', 'DisplayName', 'Optimal trajectory');
grid on;
grid minor;
hold on;
%plotting the set
plot(x0(1), x0(2), 'r*', 'DisplayName', 'Set X_{0}');
hold on;
contour(X, Y, setx1(X, Y), [c c], ...
    'DisplayName', 'Set X_{1}', 'color', 'k');

figure(figTraj);
if (timesImprov > 0)
    plot(xmaj(:, 1), xmaj(:, 2), 'r', ...
        'DisplayName', 'Improved optimal trajectory');
    grid on;
    grid minor;
    hold on;
end
%we plot -psi(t1)
quiver(xmaj(end, 1), xmaj(end, 2), psi1(1), psi1(2), ...
    'DisplayName', '-\Psi(t_1)');
%normale vector
n = n ./ norm(n);
%plotting it too
quiver(xmaj(end, 1), xmaj(end, 2), n(1), n(2), ...
    'DisplayName', 'normal', 'Color', 'r');
%checking whether we have suspiscious trajectories
h = get(gca, 'children');
if (numel(h) > numGraph)
    h = [h(1:numGraph); h(end)];
end
%and putting on good legend and title etc.
legend(h);
grid minor;
title('Trajectories');
xlabel('x_1');
ylabel('x_2');
    
%% plotting improved trajectory
figTrajMaj = figure();
p1 = subplot(2, 1, 1);
p2 = subplot(2, 1, 2);
plot(p1, t, xmaj(:, 1), 'r', 'DisplayName', 'x_1');
hold on;
legend(p1, 'show');
grid(p1, 'on');
grid(p1, 'minor');
title(p1, 'Trajectory');
xlabel(p1, 't');
ylabel(p1, 'x_1');
plot(p2, t, xmaj(:, 2), 'b', 'DisplayName', 'x_2');
legend(p2, 'show');
grid on;
grid minor;
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
grid(p1, 'minor');
title(p1, 'Control');
xlabel(p1, 't');
ylabel(p1, 'u_1');
plot(p2, t, uGrid(:, 2), 'b', 'DisplayName', 'u_2');
legend(p2, 'show');
grid on;
grid minor;
title(p2, 'Control');
xlabel(p2, 't');
ylabel(p2, 'u_2');
%% plotting psi(t)
%obtaining  
psiGrid = gridFunc(t, psimaj);

figPsi = figure();
p1 = subplot(2, 1, 1);
p2 = subplot(2, 1, 2);
plot(p1, t, psiGrid(:, 1), 'r', 'DisplayName', '\Psi_1');
hold on;
legend(p1, 'show');
grid(p1, 'on');
grid(p1, 'minor');
title(p1, '\Psi_1(t)');
xlabel(p1, 't');
ylabel(p1, '\Psi_1');
plot(p2, t, psiGrid(:, 2), 'b', 'DisplayName', '\Psi_2');
legend(p2, 'show');
grid on;
grid minor;
title(p2, '\Psi_2(t)');
xlabel(p2, 't');
ylabel(p2, '\Psi_2');
%% plotting psi in ohase
%obtaining  
psiGrid = gridFunc(t, psimaj);
figPsi2 = figure();
plot(psiGrid(:, 1), psiGrid(:, 2), 'r', 'DisplayName', '\Psi');

grid on;
grid minor;
title('\Psi(t)');
legend show;
xlabel( '\Psi_1');
ylabel( '\Psi_2');
%% Plot P and Opt Control
figU3 = figure();
umaj = @(t) p + (P * psimaj(t)) ./ (sqrt(dot(psimaj(t), P * psimaj(t))));
uGrid = gridFunc(t, umaj);
lspUX = linspace(-sqrt(r./3) + p(1),sqrt(r./3) + p(1), numOfSteps);
lspUY = linspace(-sqrt(r./2) + p(2),sqrt(r./2) + p(2), numOfSteps);
[UX, UY] = meshgrid(lspUX, lspUY);
contour(UX, UY, setP(UX, UY), [r r], 'DisplayName', 'set P');
hold on;
plot(uGrid(:, 1), uGrid(:, 2), 'r*', 'DisplayName', 'Optimal Control');
grid on;
grid minor;
legend show;
axis equal;
title('Control on set');
xlabel('u_1');
ylabel('u_2');
