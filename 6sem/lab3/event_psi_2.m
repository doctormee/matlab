function [value, isterminal, direction] = event_psi_2(t, x, maxRadius)
value = x(4);
if (max(abs(x(1:2))) > maxRadius )
    value = 0;
end
isterminal = 1;
direction = 0;
end