%%
%invariant
a = 1.715;
b = .2;
size = 10000;
u0 = .255555;
v0 = .5;
%%
a = 1.68;
b = .2;
size = 10000;
u0 = .255555;
v0 = .5;
%%
a = 2.2;
b = .2728;
size = 10000;
u0 = .255555;
v0 = .5;
%%
%
a = 1.68;
b = .2024;
size = 100000;
u0 = .255555;
v0 = .5;
%%
a = 1.68;
b = .21;
size = 10000;
u0 = .255555;
v0 = .5;
%% chaos
a = 3;
b = .261;
size = 10000;
u0 = .255555;
v0 = .5;

%% second stat 1
a = 1.1;
b = 1;
size = 10000;
u0 = .5;
v0 = .5;
%% second stat 2
a = 1.1;
b = 1;
size = 10000;
u0 = .5;
v0 = .2;
%% second stat 3
a = 1.1;
b = .4;
size = 10000;
u0 = .2;
v0 = .5;
%% I
a = .5;
b = .8;
size = 10000;
u0 = .5;
v0 = .3;
%% II
a = 2;
b = 1;
size = 10000;
u0 = .355;
v0 = .5;
%% IV
a = 2;
b = 3;
size = 10000;
u0 = .2;
v0 = .2;
%% III
a = 4;
b = 1;
size = 10000;
u0 = .5;
v0 = .5;
%% V
a = 3.5;
b = .7;
size = 10000;
u0 = .2;
v0 = .33;
%% VI
a = 2.5;
b = .4;
size = 10000;
u0 = .8;
v0 = .4;
%% VII
a = 3.1;
b = .4;
size = 10000;
u0 = .2;
v0 = .4;
%% onl one (cycle 2?)
a = 3;
b = 1;
size = 10000;
u0 = .01;
v0 = .02;

%% VIII
a = 2;
b = .245;
size = 10000;
u0 = .1;
v0 = .1;
%% 9
a = 3.1;
b = .3;
size = 10000;
u0 = .7;
v0 = .25;

%%
%plot

f = @(a, u, v) a*u*(1 - u) - u*v;
g = @(b, u, v) 1./b * u * v;
h = @(a, u) a * (1 - u); 
vecU = zeros(1, size);
vecV = zeros(1, size);
% vecU(1) = f(a, u0, v0);
% vecU(1) = (vecU(1) > 0) * vecU(1);
% vecV(1) = g(b, u0, v0);
% vecV(1) = (vecV(1) > 0) * vecV(1);
vecU(1) = u0;
vecV(1) = v0;
for i = 2:size
    vecU(i) = f(a, vecU(i - 1), vecV(i - 1));
    if (vecU(i) < 0)
        vecU(i) = 0;
    end
    vecV(i) = g(b, vecU(i - 1), vecV(i - 1));
    if (vecV(i) < 0)
        vecV(i) = 0;
    end
end;
plot(vecU, vecV, '-*');
hold on;
grid on;
xlabel('U');
ylabel('V');
plot(0, 0, 'c*');
if ((a - 1) ./ a > 0 )
    plot((a - 1) ./ a, 0, 'g*');
end
if (a*(1 - b) - 1 > 0)
    plot(b, a*(1 - b) - 1, 'r*');
end
% plot(vecU, h(a, vecU), 'b--');
%% 

f = @(a, u, v) a*u*(1 - u) - u*v;
g = @(b, u, v) 1./b * u * v;
h = @(a, u) a * (1 - u); 
vecU = zeros(1, size);
vecV = zeros(1, size);
% vecU(1) = f(a, u0, v0);
% vecU(1) = (vecU(1) > 0) * vecU(1);
% vecV(1) = g(b, u0, v0);
% vecV(1) = (vecV(1) > 0) * vecV(1);
vecU(1) = u0;
vecV(1) = v0;
for a = 1.5:0.1:2
for i = 2:size
    vecU(i) = f(a, vecU(i - 1), vecV(i - 1));
    if (vecU(i) < 0)
        vecU(i) = 0;
    end
    vecV(i) = g(b, vecU(i - 1), vecV(i - 1));
    if (vecV(i) < 0)
        vecV(i) = 0;
    end
end;
plot(vecU, vecV, '-*');
hold on;
grid on;
xlabel('U');
ylabel('V');
end