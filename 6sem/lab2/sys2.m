function  [ ret ] =  sys2( t, y, g, l, k, u )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    ret = zeros(3, 1);
    ret(1) = -g + y(2) .* (-k.*y(1)^2 + 2.*k.*y(1).*l +k.*l^2 + u.*y(1));
    ret(2) = 0;
    ret(3) = y(1) - l;
end