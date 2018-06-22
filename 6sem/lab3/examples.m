%%
alpha = 1;
t = 100;
x2opts = odeset('Events', @(t, x) event_x_2(t, x, 10000000));
[times, x] = ode45(@(t, x) odefun_S_minus(t, x, alpha), [0, t], ...
    [0, 0], x2opts);
plot(x(:,1), x(:, 2), 'c');
axis equal;
grid on;

%% 
alpha = 0.1;
t = 1.2; % 1.2, 0.5 ... 5.7
dist = .05;
N = 75;
K = 5; 
maxRadius = 10;
plotTr = true;


figure;
plot(0, 0, 'o');
grid on;
hold on;

[X, Y, switches] = reachset(alpha, t, N, plotTr, dist, K, maxRadius);

plot([X, X(1)], [Y, Y(1)], 'ko-', 'LineWidth', 1.7, 'MarkerSize', 3);
% plot(X, Y, 'b-', 'LineWidth', 1.7, 'MarkerSize', 3);
plot(switches(:, 1), switches(:, 2), '*r');

xlabel('x_1');
ylabel('x_2');
%% Function #2

alpha = 1;
dist = .5;
N = 10;
K = 10;
Kimp = 2;
maxRadius = 15;
plotTr = true;
t1 = 2.5;
t2 = 4;

filename = [];%'';

reachsetdyn(alpha, t1, t2, N, filename, K, Kimp, dist, plotTr, maxRadius);

%reachsetdyn(alpha, t1, t2, N, [], time_between_frames, K, dist);

%%

alpha =  .4;
dist = 0.1;
N = 250; %20 50
K = 1;
t = 4.25; %1 .. 5
maxRadius = 5;
plotTr = false;

figure; 
plot(0, 0, 'o');
grid on;
hold on;

[X, Y, switches] = reachset(alpha, t, N, plotTr, dist, K, maxRadius);

plot(X, Y, 'b-', 'LineWidth', 1.7, 'MarkerSize', 3);
% plot(switches(:, 1), switches(:, 2), '*r');

xlabel('x_1');
ylabel('x_2');

%%

alpha =  .5;
dist = 0.5;
N = 200;
K = 10;
t = 4.5; %1 .. 5
maxRadius = 15;
plotTr = false;


figure;
plot(0, 0, 'o');
grid on;
hold on;
for t = 1.3:4.3
[X, Y, switches] = reachset(alpha, t, N, plotTr, dist, K, maxRadius);

plot(X, Y, 'b-', 'LineWidth', 1.7, 'MarkerSize', 3);
end
xlabel('x_1');
ylabel('x_2');
% plot(switches(:, 1), switches(:, 2), '*r');
%%

v = 23;
p = 85;
for i = 24:1:84
    v = v*i;
    p = p*i;
end
p / v