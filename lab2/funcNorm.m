function [ n ] = funcNorm( f, a, b )
%funcNorm calculates func norm of f(in L2)
    n = scalarL2(f, f, a, b);
end