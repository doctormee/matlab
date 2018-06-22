function [ ret ] = full_sys1( t, y, g, l, k, u )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    ret = zeros(4, 1);
    ret(1) = -g + 1./y(2) .* (-k.*y(1)^2 + u.*(l + y(1)));
    ret(2) = -u;
    ret(3) = - 1 - y(3).*1./y(2).*(-2.*k.*y(1) + u);
    ret(4) = -y(3).*1./y(2).^2.*(k.*y(1).^2 - u.*(l + y(1)));
end

