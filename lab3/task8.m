%%predator-prey
% x' = alpha * x - gamma * xy -- prey equation
% y' = -beta * y + delta * xy -- predator equation
% basic example
clear
alpha = .5; %prey growth factor
beta = 1; %predator death factor
gamma = 1; %prey death factor after meeting predator
delta = 1; %predator growth factor after killing prey
x0 = 100; %initial population of prey
y0 = 1; %initial populaton of predators
init = [x0, y0];
tbegin = 0; %starting time
tend = 1000; %final time
tspan = [tbegin tend]; %whole timespan
%% rabbits and alligators 
clear
alpha = 10; %prey growth factor
beta = .1; %predator death factor
gamma = .5; %prey death factor after meeting predator
delta = .1; %predator growth factor after killing prey
x0 = 10; %initial population of prey
y0 = 20; %initial populaton of predators
init = [x0, y0];
tbegin = 0; %starting time
tend = 100; %final time
tspan = [tbegin tend]; %whole timespan
%% stationary point
clear
alpha = 10; %prey growth factor
beta = .1; %predator death factor
gamma = .5; %prey death factor after meeting predator
delta = .1; %predator growth factor after killing prey
x0 = beta ./ delta; %initial population of prey
y0 = alpha ./ gamma; %initial populaton of predators
init = [x0, y0];
tbegin = 0; %starting time
tend = 100; %final time
tspan = [tbegin tend]; %whole timespan
%% leopards and deers
clear
alpha = 1; %prey growth factor
beta = .5; %predator death factor
gamma = .1; %prey death factor after meeting predator
delta = .25; %predator growth factor after killing prey
x0 = 20; %initial population of prey
y0 = 1; %initial populaton of predators
init = [x0, y0];
tbegin = 0; %starting time
tend = 100; %final time
tspan = [tbegin tend]; %whole timespan
%% chinese massacre
clear
alpha = 100; %prey growth factor
beta = 10; %predator death factor
gamma = 10; %prey death factor after meeting predator
delta = .1; %predator growth factor after killing prey
x0 = 1000; %initial population of prey
y0 = 1; %initial populaton of predators
init = [x0, y0];
tbegin = 0; %starting time
tend = 100; %final time
tspan = [tbegin tend]; %whole timespan
%% lazy predator
clear
alpha = 1; %prey growth factor
beta = .1; %predator death factor
gamma = 1; %prey death factor after meeting predator
delta = .01; %predator growth factor after killing prey
x0 = 100; %initial population of prey
y0 = 1; %initial populaton of predators
init = [x0, y0];
tbegin = 0; %starting time
tend = 100; %final time
tspan = [tbegin tend]; %whole timespan
%% dying prey
clear
alpha = -1; %prey growth factor
beta = .1; %predator death factor
gamma = 1; %prey death factor after meeting predator
delta = .1; %predator growth factor after killing prey
x0 = 100; %initial population of prey
y0 = 1; %initial populaton of predators
init = [x0, y0];
tbegin = 0; %starting time
tend = 100; %final time
tspan = [tbegin tend]; %whole timespan
%% evaluation
sysFun = @(t, y) [alpha .* y(1) - gamma .* y(1) .* y(2); ...
    -1 .* beta .* y(2) + delta .* y(1) .* y(2);]; % system of ODE for ode45
[T, F] = ode45(sysFun, tspan, init);
figure(1);
plot(F(:, 1), F(:, 2), 'k');
grid on;
xlabel('PREY');
ylabel('PREDATORS');
% hold on;
figure(2);
plot3(F(:, 1), F(:, 2), T, 'r');
grid on;
xlabel('PREY');
ylabel('PREDATORS');
zlabel('Time');


