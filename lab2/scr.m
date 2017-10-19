circle = @(x)(x(1)-1).^2+x(2).^2-4;
g = supportLebesgue(circle, []);
plg = @(phi) polg(g, phi);
gpol = supportLebesgue(plg, []);
drawSet(gpol, 10);
    
    