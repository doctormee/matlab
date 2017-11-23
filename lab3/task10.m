

% task:
% for systems
%   x' = y - x + xy, x from R,
%   y' = x - y - x.^2 - y.^3, y from R,
% and
%   x' = x.^2 +2 .* y.^3, x from R,
%   y' = x .* y.^2, y from R,

clc
clear
%% system 1 
clc
clear variables
%  Lyapunov function 
v = @(x, y) x.^2 + y.^2;
% function is differentiable, positive in case x^2 + y^2 ~= 0
% and v(0,0) = 0, so full derivative looks like:
% dv_dt = 2xx' + 2yy' = -2((x - y).^2 + y.^4) <= 0 
% then according to the second Lyapunov theorem the solution
% is asymptotically sustainable

t0 = 0;
tf = 10;
nTrajectories = 20;
theta = linspace(0, 2*pi, nTrajectories);
r = 5;
max = 4;

%  level lines 
figure(1);
cla; % clear axes
axis([-max max -max max]);
hold on;
step = .1;
[X, Y] = meshgrid(-max:step:max, -max:step:max);
Z = v(X, Y);
contourN = 10;
[C, h] = contour(X, Y, Z, contourN);
colorbar
list = h.LevelList;
lValMax = list(contourN);
lValMin = list(1);
colormap autumn;
colour = colormap;
%  phase portrait
for i=1:nTrajectories
    y0 = [r*cos(theta(i)), r*sin(theta(i))];
    [~, F] = ode45(@t10f, [t0, tf], y0);
    length = size(F, 1);
    partN = 10; 
    piece = length ./ partN;
    for j = 1:(partN)
        curfirst = floor(piece * (j - 1)) + 1;
        curpar = (curfirst : min(floor(piece * j + 1), length));
        lVal = v(F(curfirst, 1), F(curfirst, 2));
        clear valMaxInd;
        valMaxInd = find( (lVal - list) >= 0);
        if (isempty(valMaxInd))
            maxInd = 1;
        else
            maxInd = valMaxInd(numel(valMaxInd));
        end;
        curcol = colour(floor(((1 ./ contourN) .* (maxInd - 1)) .* 64) + 1, :);
        plot(F(curpar, 1), F(curpar, 2), 'Color', curcol); 
        U = F(curpar, 2) - F(curpar, 1) + F(curpar, 1) .* F(curpar, 2);
        V = F(curpar, 1) .* (1 - F(curpar, 1)) - F(curpar, 2) .* (1 - F(curpar, 2) .^ 2);
        quiver(F(curpar, 1), F(curpar, 2), U, V, 0.5, 'Color', curcol);

    end
end;

title('first system: x'' = y - x + xy; y'' = x - y - x^2 - y^3');
legend('contour plots', 'trajectories');
hold off
%%  system 2 
clc
clear variables
    % Lyapunov function
    v = @(x, y) x.^2 - 2.*y.^2;
    % x, y > 0; y < x: 
    % v(x, y) > 0,
    % dv_dt = 2.*x.^3 == w(x,y) > 0 
    % so according to Chataev theorem the solution is NOT sustainable
    
    % initial data, variables, params
    
t0 = 0;
tf = 10;
nTrajectories = 20;
theta = linspace(0, 2*pi, nTrajectories);
r = 4;
max = 10;

%  level lines 
figure(2);
cla; % clear axes
axis([-max max -max max]);
hold on;
step = .1;
[X, Y] = meshgrid(-max:step:max, -max:step:max);
Z = v(X, Y);
contourN = 10;
[C, h] = contour(X, Y, Z, contourN);
colorbar
list = h.LevelList;
lValMax = list(contourN);
lValMin = list(1);
colormap autumn;
colour = colormap;
%  phase portrait
for i=1:nTrajectories
    y0 = [r*cos(theta(i)), r*sin(theta(i))];
    [~, F] = ode45(@t10f2, [t0, tf], y0);
    length = size(F, 1);
    partN = 10; 
    piece = length ./ partN;
    for j = 1:(partN)
        curfirst = floor(piece * (j - 1)) + 1;
        curpar = (curfirst : ceil((piece * j)));
        lVal = v(F(curfirst, 1), F(curfirst, 2));
        clear valMaxInd;
        valMaxInd = find( (lVal - list) >= 0);
        if (isempty(valMaxInd))
            maxInd = 1;
        else
            maxInd = valMaxInd(numel(valMaxInd));
        end;
        curcol = colour(floor(((1 ./ contourN) .* (maxInd - 1)) .* 64) + 1, :);
        plot(F(curpar, 1), F(curpar, 2), 'Color', curcol); 
        U = F(curpar, 1).^2 + 2 .* F(curpar, 2) .^ 3;
        V = F(curpar, 1) .* F(curpar, 2).^2;
        quiver(F(curpar, 1), F(curpar, 2), U, V, 0.7, 'Color', curcol);
    end
%     U = F(:, 2) - F(:, 1) + F(:, 1) .* F(:, 2);
%     V = F(:, 1) .* (1 - F(:, 1)) - F(:, 2) .* (1 - F(:, 2) .^ 2);
%     quiver(F(:, 1), F(:, 2), U, V, 0.5);
end;
title('second system:  x'' = x^2 +2 * y^3; y'' = x * y^2');
legend('contour plots', 'trajectories');
hold off