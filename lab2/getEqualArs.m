function [x, y] = getEqualArs(f, g, t0, t1, n) 
syms t; 
syms s; 
L = int(sqrt((diff(f(t))^2 + (diff(g(t)))^2)), t, t0, t1); 
x = zeros(1, n); 
x(1) = f(t0); 
x(n) = f(t1); 
y = zeros(1, n); 
y(1) = g(t0); 
y(n) = g(t1); 
Len = L/(n - 1); 
t_left = t0; 
for i = 2 : (n - 1) 
t_right = solve(int(sqrt((diff(f(t)))^2 + (diff(g(t)))^2), t, t_left, s) == Len, s); 
x(i) = f(t_right); 
y(i) = g(t_right); 
t_left = t_right; 
end 
end