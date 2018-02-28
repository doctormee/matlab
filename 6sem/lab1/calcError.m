function [ error, n ] = calcError( a, b, c, x11, x12, x0, psi, t, moe )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    if (norm(x0.' - [x11 + sqrt(c ./ a); x12]) < moe)
        n = [(2 .* a ./ b ).* sqrt(c ./ a); 1];
        n = n ./ norm(n);
        secAngle = abs(n(2));
        psi = -psi(t(end));
        psi = psi ./ norm(psi);
        error = abs(psi(2));
        if (error <= secAngle)
            error = 0;
        else
            error = error - secAngle;
        end
    elseif (norm(x0.' - [x11 - sqrt(c ./ a); x12]) < moe)
        n = [-(2 .* a ./ b ).* sqrt(c ./ a); 1];
        n = n ./ norm(n);
        secAngle = abs(n(2));
        psi = -psi(t(end));
        psi = psi ./ norm(psi);
        error = abs(psi(2));
        if (error <= secAngle)
            error = 0;
        else
            error = error - secAngle;
        end
    else
        n = [(2 .* a ./ b ).* (x0(1) - x11); 2 .* (x0(2) > x12) - 1];
        error = real(sqrt(1 - (dot(-psi(t(end)), n) ./ ...
            (norm(-psi(t(end))) .* norm(n))).^2));
    end
end

