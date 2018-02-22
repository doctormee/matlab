function [ error, n ] = calcError( a, b, c, x11, x12, x0, psi, t, moe )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    if (norm(x0.' - [x11 + sqrt(c ./ a); x12]) < moe)
        
    elseif (norm(x0.' - [x11 - sqrt(c ./ a); x12]) < moe)
       
        
    else
        n = [(2 .* a ./ b ).* (x0(1) - x11); 2 .* (x0(2) > x12) - 1];
        error = real(sqrt(1 - (dot(-psi(t(end)), n) ./ ...
            (norm(-psi(t(end))) .* norm(n))).^2));
    end
end
