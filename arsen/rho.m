function [val, points] = rho( l )
    val = sqrt(2 .* l(1, :).^2 + 2 .* l(2, :).^2);
    size_of_l = size(l);
    points = zeros(2, size_of_l(2));
    points(1, :) = 2 .* l(1, :) ./ sqrt(l(1, :).^2 + l(2, :).^2);
    points(2, :) = 2 .* l(2, :) ./ sqrt(l(1, :).^2 + l(2, :).^2);
end

