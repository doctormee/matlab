function drawPolar(rho, n)
    t0 = 0;
    t1 = 2* pi;
    t = linspace(t0, t1, n);
    epsyl = 0.1;
    l = [cos(t); sin(t)];
    [val, points] = rho(l);
    x = points(1, :);
    y = points(2, :);
    x_polar = l(1, :) ./ val;
    y_polar = l(2, :) ./ val;
    [~, ~, lim_vect] = find(val >= epsyl);
    %{
    disp(x_polar);
    disp(y_polar);
    [~, unlim_peaks_max] = findpeaks(x_polar);
%    [~, unlim_peaks_min] = findpeaks(-x_polar)
    x_polar(1, unlim_peaks_max(1, 1):(unlim_peaks_max(1, 2)-1)) = x_polar(1, (unlim_peaks_max(1, 2) -1): -1 :unlim_peaks_max(1, 1)) ;
    y_polar(1, unlim_peaks_max(1, 1):(unlim_peaks_max(1, 2)-1)) = x_polar(1, (unlim_peaks_max(1, 2) -1): -1 :unlim_peaks_max(1, 1)) ;
    %}
    if ~flag 
        disp('a');
        plot(x, y, x_polar, y_polar);
    else
        if max(x) > max(x_polar(lim_vect))
            max_x = max(x);
        else
            max_x = max(x_polar(lim_vect));
        end
        if max(y) > max(y_polar(lim_vect))
            max_y = max(y);
        else
            max_y = max(y_polar(lim_vect));
        end
        if min(x) < min(x_polar(lim_vect))
            min_x = min(x);
        else
            min_x = min(x_polar(lim_vect));
        end
        if min(y) < min(y_polar(lim_vect))
            min_y = min(y);
        else
            min_y = min(y_polar(lim_vect));
        end
        plot(x, y, 'b');
        fill(x, y, 'b');
        hold on;
        plot(x_polar, y_polar, 'r');
        fill(x_polar, y_polar, 'r');
        axis([min_x max_x min_y max_y]);
    end
    grid;
    title('Polar image');
    legend('initial set', 'polar set');
    xlabel('x');
    ylabel('y');
end

