  function [ ret ] = full_sys2( t, y, g, l, k, u )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    ret = zeros(4, 1);
    ret(1) = -g + 1./y(2) .* (-k.*y(1)^2);
    ret(2) = 0;
    ret(3) = - 1 - y(3).*1./y(2).*(-2.*k.*y(1));
    ret(4) = -y(3).*1./y(2).^2.*(k.*y(1).^2);
end

