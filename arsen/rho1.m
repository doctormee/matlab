function [ val, points ] = rho1( l )
    val = sqrt(l(1, :).^2 + l(2, :).^2) + 2*(l(1, :) + l(2, :));
    size_of_l = size(l);
    points = zeros(2, size_of_l(2));
    points(1, :) = l(1, :) ./ sqrt(l(1, :).^2 + l(2, :).^2) + 2;
    points(2, :) = l(2, :) ./ sqrt(l(1, :).^2 + l(2, :).^2) + 2;
end

