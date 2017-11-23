function drawManyBalls(alphas, colors, edges)
    h = axes();
    daspect([1,1,1]);
    view(3); 
    axis tight
    camlight 
    lighting gouraud
    R = length(alphas);
    for i = 1:R
        if alphas(i) <= 0 
            disp('Incorrect input!');
            return;
        else
            s = struct('color', '', 'edgecolor', '', 'N', 0, 'axes_handler', 0);
            s.axes_handler = h;
            s.N = 100; % default
            s.color = colors{i};
            s.edgecolor = edges{i};
            drawBall(alphas(i), s);
        end
        getframe();
    end
            
end