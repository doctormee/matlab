% Task 9
clear variables;
clc
%% Stable node (0,0)
figure;
a = 2;
axis([-a a -a a]);
axis equal;
hold on; 
for theta = -pi:pi/14:pi                                        
    x0 = [a .* cos(theta); a .* sin(theta)];
    [t, x] = ode45(@StableNode, [0 5], x0);                    
    p1 = plot(x(:, 1), x(:, 2), 'r', 'LineWidth', 0.2);
    quiver(x(:, 1), x(:, 2),-x(:, 1), 2 * x(:, 1) - 2 * x(:, 2), 0.8, 'r');
    grid on;
    xlabel('x');
    ylabel('y');
    title('Stable Node');
end
x = linspace(-a, a, 10);
p2 = plot(0*x, x, 'g--');                                           % eigenvectors
plot(x, 2 * x, 'g--');
hold off;
legend([p1 p2], 'Trajectory', 'Eigenvectors', 'Location', 'northeast');
%%  Dicritical node (0,0)
figure;
a = 3;
axis([-a a -a a])
axis equal;
hold on 

for theta = -pi:pi/10:pi
    x0 = [a * cos(theta); a * sin(theta)];
    [~, x] = ode45(@DicriticalNode,[0 5], x0);
    plot(x(:, 1), x(:, 2), 'r', 'LineWidth', 0.2);
    quiver(x(:, 1), x(:, 2), -x(:, 1), -x(:, 2), 0.8, 'r');
    grid on;
    xlabel('x');
    ylabel('y');
    title('Dicritical Node');
end
%% Stable Degenerate node (0,0)
figure;
a = 3;
axis([-a a -a a])
axis equal;
hold on 
for theta = -pi:(pi/10):pi
    x0 = [a .* cos(theta); a .* sin(theta)];
    [~, x] = ode45(@StableDegenerateNode,[0 10], x0);
    p1 = plot(x(:, 1), x(:, 2), 'r', 'LineWidth', 0.2);
    quiver(x(:, 1), x(:, 2), -3 * x(:, 1) + 2 * x(:, 2), -2 * x(:, 1) + x(:, 2), 0.8, 'r');
    grid on;
    xlabel('x');
    ylabel('y');
    title('Stable Degenerate node');
end
x = linspace(-a, a, 10);
p2 = plot(x, x, 'g--');
hold off;
legend([p1 p2], 'Trajectory', 'Eigenvector', 'Location', 'northeast');

%% Saddle (0,0)
figure;
hold on;
a = 10;
b = 2;
axis([-a a -b b])
for theta = (-a:a) / 2
    x0 = [theta b];
    [~, x] = ode45(@Saddle, [0 b], x0);
    p1 = plot(x(:, 1), x(:, 2), 'r');
    quiver(x(:, 1), x(:, 2), 4 * x(:, 1) - 2 * x(:, 2), -3 * x(:, 2), 0.4, 'r');
    x0 = [theta -b];
    [~, x] = ode45(@Saddle, [0 b], x0);
    plot(x(:, 1), x(:, 2), 'r');
    quiver(x(:, 1), x(:, 2), 4 * x(:, 1) - 2 * x(:, 2), -3 * x(:, 2), 0.4, 'r');
    grid on;
    xlabel('x');
    ylabel('y');
    title('Saddle');
end
x = linspace(-a, a, 10);
p2 = plot(2 * x, 7 * x, 'g--');
plot(x, 0*x, 'g--');
hold off;
legend([p1 p2], 'Trajectory', 'Eigenvectors', 'Location', 'northwest');



%% Centre (0, 0)
figure;
hold on;
for theta = -pi:(pi / 15):pi
    x0 = [cos(theta); sin(theta)];
    [~, x] = ode45(@Centre, [0 4], x0);
    plot(x(:, 1), x(:, 2), 'r', 'LineWidth', 0.2);
    quiver(x(:, 1), x(:, 2), x(:, 1) - x(:, 2), 2 * x(:, 1) - x(:, 2), 0.25, 'r') 
    grid on;
    xlabel('x');
    ylabel('y');
    title('Centre');
end


%% Stable Focus (0, 0)
figure;
hold on;
a = 1;
axis([-a a -a a]);
for theta = -pi:(pi / 5):pi
    x0 = [cos(theta); sin(theta)];
    [~, x] = ode45(@StableFocus, [0 10], x0);
    plot(x(:, 1), x(:, 2), 'r', 'LineWidth', 0.2);
    quiver(x(:, 1), x(:, 2), -2*x(:, 2), x(:, 1) - x(:, 2), 0.8, 'r');
    grid on;
    xlabel('x');
    ylabel('y');
    title('Stable Focus');
end

%% Unstable Focus (0, 0)
figure;
hold on;
a = 1;
axis([-a a -a a]);
for theta = -pi:(pi / 5):pi
    x0 = [cos(theta); sin(theta)];
    [~, x] = ode45(@StableFocus, [0 10], x0);
    plot(x(:, 1), x(:, 2), 'r', 'LineWidth', 0.2);
    quiver(x(:, 1), x(:, 2), -(-2*x(:, 2)), -(x(:, 1) - x(:, 2)), 0.8, 'r');
    grid on;
    xlabel('x');
    ylabel('y');
    title('Unstable Focus');
end
%% t10f
figure
hold on;
a = 2;
axis([-a a -a a]);
for theta = 0:(pi / 10):(2 .* pi)
    x0 = [a .* cos(theta); a .* sin(theta)];
    [~, x] = ode45(@t10f, [0 100], x0);
    plot(x(:, 1), x(:, 2), 'r', 'LineWidth', 0.2);
    quiver(x(:, 1), x(:, 2), x(:, 2) - x(:, 1) + x(:, 1) .* x(:, 2), ...
        x(:, 1) .* (1 - x(:, 1)) + x(:, 2) .* (1 - x(:, 2) .^ 2), 0.8, 'r');
    grid on;
    xlabel('x');
    ylabel('y');
    title('For task 10, system 1');
end
%% t10f2
figure
hold on;
a = 1;
axis([-a a -a a]);
for theta = 0:(pi / 10):(2 .* pi)
    x0 = [a .* cos(theta); a .* sin(theta)];
    [~, x] = ode45(@t10f2, [0 10], x0);
    plot(x(:, 1), x(:, 2), 'r', 'LineWidth', 0.2);
    quiver(x(:, 1), x(:, 2), x(:, 1) .^ 2 + 2 .* x(:, 2) .^ 3, ...
        x(:, 1) .* x(:, 2) .^ 2, 0.8, 'r');
    grid on;
    xlabel('x');
    ylabel('y');
    title('For task 10, system 2');
end
% %% Degenerate System
% figure;
% hold on;
% a = 1;
% axis([-a a -a a]);
% for theta = 0:(pi / 5):2.*pi
%     x0 = [cos(theta); sin(theta)];
%     [~, x] = ode45(@Degenerate, [0 10], x0);
%     plot(x(:, 1), x(:, 2), 'r', 'LineWidth', 0.2);
%     quiver(x(:, 1), x(:, 2), x(:, 1) + x(:, 2), 2.*(x(:, 1) + x(:, 2)), 0.8, 'r');
%     grid on;
%     xlabel('x');
%     ylabel('y');
%     title('Degenerate');
% end
