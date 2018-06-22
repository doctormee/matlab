function [value, isterminal, direction] = event_x_2(t, x, maxRadius)
value = x(2);
if (max(abs(x)) > maxRadius)
    value = 0;
end
% if (x(2) < 1) && (x(1) > 1)
%     
% end
isterminal = 1;
direction = 0;
end