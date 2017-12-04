function [value, isterminal, direction] = collision_event(t, x, x_center, y_center, R)
    value = sqrt(((x(1) - x_center).^2 + (x(3) - y_center).^2)) - R;
    isterminal = 1;
    direction = 1;
end