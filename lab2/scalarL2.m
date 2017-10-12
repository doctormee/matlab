function [ n ] = scalarL2( f, g, a, b )
%funcNorm calculates scalar multiplication of f and g from a to b
    syms x;
    f = symfun(f(x), x);
    g = symfun(g(x), x);
    n = double(int((f * g), x, a, b));
end