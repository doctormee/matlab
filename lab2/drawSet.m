function  drawSet(rho, N)
% function DrawSet gets support function of a set 
% [val, point] = rho(x), which returns the value of support function and 
% corresponding vector, and draws piecewise llnear
% approximation of the border with N points via circumscribed and inscribed
% polygons
    phi0 = 0;
    phi1 = 2 .* pi;
    t = linspace(phi0, phi1, N);  % linear grid with N points
    inscX = zeros(1, N);            % support vector coordinates  
    inscY = zeros(1, N);            
    circX = zeros(1, N + 1);      % polygons coordinates
    circY = zeros(1, N + 1);  
    syms sx;    % tangent intersection
    syms sy;    % coordinates
    r1 = [0 0];     
    r2 = [0 0]; % previous and current radius - vectors respectivly
    c1 = 0;     % previous tangent    
    c2 = 0;     % current tangent  
    for k = 1:N    
        r1 = r2;                % saving last directions
        r2 = [cos(t(k)) sin(t(k))]; % current direction
        [val point] = rho(r2);      % finding support vector for current directio
        inscX(k) = point(1); % tangent point
        inscY(k) = point(2); % coordinates
        if(k == 1)
            c2 = - r2(1)*inscX(k) - r2(2)*inscY(k); 
            % finding c
        else
            if(k > 1)
            c1 = c2; % c for tangent of previous point
            c2 = -r2(1)*inscX(k) - r2(2)*inscY(k); % c for tangent of current point
            % find point of intersection
            [circX(k-1), circY(k-1)] = solve(r1(1)*sx + r1(2)*sy + c1, ...
                                             r2(1)*sx + r2(2)*sy + c2, sx, sy);
            end;
        end;
    end;
    % find point of intersection of tangent for the first point and the last
    r1 = r2;
    r2 = [cos(t(1)) sin(t(1))];
    c1 = c2;
    c2 = - r2(1)*inscX(1) - r2(2)*inscY(1);
    eps = 0.0000001;
    if((r1(1)-r2(1)) < eps && (r1(2)-r2(2)) < eps)
        circX(N) = circX(1);
        circY(N) = circY(1);
    else
        [circX(N), circY(N)] = solve(r1(1)*sx + r1(2)*sy + c1, ...
                                     r2(1)*sx + r2(2)*sy + c2, sx, sy);
    end;
    % inscribed poligons
    figure;
    plot(inscX, inscY, 'r-');
    grid on;
    hold on;
    % connecting points
    circX(N + 1) = circX(1);
    circY(N + 1) = circY(1);
    % circumscribed poligons
    plot(circX, circY, 'b-');
    legend('approximation via inscribed polygons', ...
           'approximation via circumscribed polygons');
    xlabel('X');
    ylabel('Y');
end
