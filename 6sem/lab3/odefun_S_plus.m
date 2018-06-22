function dfunc = odefun_S_plus(t, x, alpha)
dfunc = [x(2); atan(x(1)^2) + alpha - x(1)*x(2) - cos(x(1)^2)*x(1)^2];
end