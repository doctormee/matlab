function [ ret ] = full_sys3( t, y, g, l, k, umin, umax)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    ret = zeros(4, 1);
    u = 1./2 .* (-y(3).*(l + y(1)) + y(4));
    if (u < umin)
        u = umin;
    elseif (u > umax)
        u = umax;
    end;
    ret(1) = -g + 1./y(2) .* (-k.*y(1)^2 + u.*(l + y(1)));
    ret(2) = -u;
    ret(3) = -1 - y(3).*1./y(2).*(-2.*k.*y(1) + u);
    ret(4) = -y(3).*1./y(2).^2.*(k.*y(1).^2 - u.*(l + y(1)));
end

