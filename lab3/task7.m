clear;
clc;
moe = .000001;
x_center = 1;
y_center = 0;
alpha = 1;
R = 3;

ptime = .005;
x_min = x_center - R;
x_max = x_center + R;
y_min = y_center - R;
y_max = y_center + R;
shift = 1;
size_lsp = 100;
x_lsp = linspace(x_min, x_max, size_lsp);
y_lsp = linspace(y_min, y_max, size_lsp);
[X,Y] = meshgrid(x_lsp,y_lsp);
T_start = 0;
T_final = 500;
opts = odeset('Events', @(t, x) collision_event(t, x, x_center, y_center, R));
x0 = [0; 1];
v0 = [1; .5];
y0 = [x0(1); v0(1); x0(2); v0(2)];
circle_func = @(x, y) (x - x_center).^2 + (y - y_center).^2 - R^2;
% old_Y = y0';
Z = circle_func(X,Y);
contour(X, Y, Z, [0,0]);
hold on;
while 1
    [T, Y] = ode45(@odefun, [T_start, T_final], y0, opts);
    disp(T(end));
    T_start = T(end);
    if (abs((Y(end, 1) - x_center)^2 + (Y(end, 3) - y_center)^2 - R^2) <= moe) 
        y0(1) = Y(end, 1);
        y0(3) = Y(end, 3);
        v1 = reflection(y0, x_center, y_center, R, alpha);
        y0(2) = v1(1);
        y0(4) = v1(2);
    end
%     new_Y = cat(1, old_Y, Y);
    plot(Y(:, 1), Y(:, 3), '-r');
    axis([x_min - shift, x_max + shift, y_min - shift, y_max + shift]);
    grid on;
    pause(ptime);
%     old_Y = Y;
    if (T(end) >= T_final)
        break
    end
end
hold off;