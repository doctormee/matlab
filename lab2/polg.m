function [n] = polg(g, phi)
    [n, point] = g(phi);
    n = n - 1;
end