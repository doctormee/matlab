function [] = compareInterp(x, xx, f)
%compareInterp draws F on xx grid and interpolation from x to xx 
    if ~(ismember(x, xx))
        disp('Error! X must lie within XX!');
        return;
    end;
    y = f(x);
    nearY = interp1(x, y, xx, 'nearest');
    linY = interp1(x, y, xx, 'linear');
    splineY = interp1(x, y, xx, 'spline');
    cubicY = interp1(x, y, xx, 'PCHIP');
    figure;
    plot(xx, f(xx), '-r');
    grid on;
    hold on;
    plot(xx, nearY, '-b');
    plot(xx, linY, '-g');
    plot(xx, splineY,'-c');
    plot(xx, cubicY, '-k');
    title('Function and different interpolations');
    legend('Function', 'Nearest interp.', 'Linear interp.',...
        'Spline interp.', 'Cubic interp.');
end

