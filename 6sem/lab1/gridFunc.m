function [ res ] = gridFunc( t, u )
%gridFunc returns a grid approximation of u(t)
    res = zeros(numel(t), 2);
    for j = 1:numel(t)
        res(j, :) = u(t(j));
    end
end

