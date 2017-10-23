function drawManyBalls(alphas, colors, edges)
    % get axis and put camlight before any cycles
    % to get an optimal programm
    h = axes();
    daspect([1,1,1]);
    view(3); axis tight
    camlight 
    lighting gouraud
    s = struct('color', '', 'edgecolor', '', 'N', 0, 'axes_handler', 0);
    s.axes_handler = h;
    s.color = colors;
    s.edgecolor = edges;
    s.N = 100; % default
    R = length(alphas);
    for i = 1:R
        if alphas(i) <= 0 
            disp('input is incorrect');
            return;
        else
            if alphas(i) == inf
 %              figure;
                drawBall(alphas(i), s);
            else
 %              figure;
                drawBall(alphas(i), s);
            end
        end
        getframe();
    end
            
end