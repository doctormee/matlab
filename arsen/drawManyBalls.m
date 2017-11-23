function drawManyBalls(alphas, colors, edgecolors)
    R = length(alphas);
    for i = 1:R
        if alphas(i) <= 0 
            disp('input is incorrect');
            return;
        else
            if i > numel(colors)
                color = 'g';
            else
                color = colors{i};
            end
            if i > numel(edgecolors)
                edgecolor = 'b';
            else
                edgecolor = edgecolors{i};
            end
            s = getParam(color, edgecolor, 100, 1);
            figure;
            drawBall(alphas(i), s);
        end
    getframe();
    end 
end