function v1 = reflection(y0, x_center, y_center, R, alpha)
v0 = [y0(2); y0(4)];
dir = [y0(1) - x_center; y0(3) - y_center] ./ R;
v1 = v0 - 2 * dot(v0, dir) * dir;
v1 = v1 .* alpha;
end
