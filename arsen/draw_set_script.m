%% 
opts = optimoptions('fmincon', 'Display', 'off');

%%

rho = supportPoint([5 -5]);
drawSet(rho, 50);

%%

f = @ (x) x(1) .^ 2 + x(2) .^ 2 - 1;
rho = supportLebesgue(f, opts);
drawSet(rho, 8);

%%

clc;
drawPolar(@rho1, 100);

%%

drawPolar(@rho, 100);
    
%%

f = @ (x) x(1) .^ 2 + x(2) .^ 2 - 10;
rho = supportLebesgue(f, opts);
drawPolar(rho, 100);

