function dydt = t10f2(t, y)
    dydt = [y(1).^2 + 2.*y(2).^3; y(1) .* y(2).^2];
end