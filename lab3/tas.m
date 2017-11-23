v = @(x, y) x.^2 + y.^2;
 %v = @(x, y) x.^2 - 2 * y.^2;
    %t0 = 0;
    %tf = 10;
    t0 = 10;
    tf = 0;
    n = 20;
    phi = linspace(0, 2*pi, n);
    r = 4;
    max = 4;
    axis([-max max -max max]);
    hold on;
    [X, Y] = meshgrid(-max:0.1 :max, -max:0.1:max);
    Z = v(X, Y);
    %colormap cool;
    contour(X, Y, Z);
    %colorbar;
    if ~ishold
            hold;
        end;
    linecolors = jet(n);
    for count=1:n
        y0 = [r*cos(phi(count)), r*sin(phi(count))];
%         [t, F] = ode45(@t10f, [tf, t0], y0);
%         [t1, F1] = ode45(@t10f, [t0, tf], y0);
        [t, F] = ode45(@t10f2, [tf, t0], y0);
        [t1, F1] = ode45(@t10f2, [t0 tf], y0);
%         set(0,'DefaultAxesColorOrder',autumn)
        plot(F(:, 1), F(:, 2), 'color', linecolors(count,:));
        plot(F1(:, 1), F1(:, 2), 'color', linecolors(count,:)); 
        m = 0;
        n = 0;
        for i = 1 : size(F(:, 1))
           m = m + 1;
           if (abs(F(m,1)) >= max || abs(F(m, 2)) >= max)
               F(m,:) = [];
               m = m-1;
           end;       
        end;
        for i = 1 : size(F1(:, 1))
            n = n + 1;
            if (abs(F1(n, 1)) >= max || abs(F1(n, 2)) >= max )
              F1(n, :) = [];
              n = n - 1;
           end; 
        end;
       X = F(:, 1);
       Y = F(:, 2);
       U = F(:, 1) .^ 2 + 2 * F(:, 2) .^ 3;
       V = F(:, 1) .* F(:, 2) .^ 2;
       X1 = F1(:, 1);
       Y1 = F1(:, 2);
       U1 = F1(:, 1) .^ 2 + 2 * F1(:, 2) .^ 3;
       V1 = F1(:, 1) .* F1(:, 2) .^ 2;
      
       %quiver(X(abs(X) < 2 & abs(Y) < 2), Y(abs(X) < 2 & abs(Y) < 2), U(abs(X) < 2 & abs(Y) < 2), V(abs(X) < 2 & abs(Y) < 2), 'r');
       %quiver(X1(abs(X1) < 2 & abs(Y1) < 2), Y1(abs(X1) < 2 & abs(Y1) < 2), U1(abs(X1) < 2 & abs(Y1) < 2), V1(abs(X1) < 2 & abs(Y1) < 2), 'r');
       % quiver(X(abs(Y) > 2 & abs(Y) < 4 | abs(X) > 2 & abs(X) < 4), Y(abs(Y) > 2 & abs(Y) < 4 | abs(X) > 2 & abs(X) < 4), U(abs(Y) > 2 & abs(Y) < 4 | abs(X) > 2 & abs(X) < 4), V(abs(Y) > 2 & abs(Y) < 4 | abs(X) > 2 & abs(X) < 4), 'm');
        %quiver(X1(abs(Y1) > 2 & abs(Y1) < 4 | abs(X1) > 2 & abs(X1) < 4), Y1(abs(Y1) > 2 & abs(Y1) < 4 | abs(X1) > 2 & abs(X1) < 4), U1(abs(Y1) > 2 & abs(Y1) < 4 | abs(X1) > 2 & abs(X1) < 4), V1(abs(Y1) > 2 & abs(Y1) < 4 | abs(X1) > 2 & abs(X1) < 4), 'm');
        quiver(F(:, 1), F(:, 2), F(:, 2) - F(:, 1) + F(:, 1) .* F(:, 2), F(:, 1) - F(:, 2) - F(:, 1).^2 - F(:, 2).^3);
        %quiver(F1(:, 1), F1(:, 2), F1(:, 2) - F1(:, 1) + F1(:, 1) .* F1(:, 2), F1(:, 1) - F1(:, 2) - F1(:, 1).^2 - F1(:, 2).^3, 'k');
        %quiver(F(:, 1), F(:, 2), (F(:, 1) .^ 2 + 2 * F(:, 2) .^ 3), (F(:, 1) .* F(:, 2) .^ 2));
       %quiver(F1(:, 1), F1(:, 2), (F1(:, 1) .^ 2 + 2 * F1(:, 2) .^ 3), (F1(:, 1) .* (F1(:, 2)) .^ 2))
    end;
    legend('????? ??????', '??????????');
    hold off