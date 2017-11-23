function drawBall(alpha, params)
    if alpha <= 0 
        disp('input is incorrect');
        return;
    else
        if alpha == inf
            f = @(x,y,z) (max(max(abs(x), abs(y)), abs(z)));
        else
            f = @(X, Y, Z) (abs(X).^alpha + abs(Y).^alpha + abs(Z).^alpha);
        end
        h = 10 / params.points;
        [X,Y,Z] = meshgrid(-10:h:10);
        V = f(X, Y, Z);
        if params.isoval <= 0 || params.isoval >= 10
            isovalue = 1;
        else
            isovalue = params.isoval;
        end
        p = patch(isosurface(X, Y, Z, V, isovalue));
        hold on;
        p.FaceColor = params.color;
        p.EdgeColor = params.edgecolor;
        view(3); 
        daspect([1, 1, 1]);
        camlight ;
        lighting flat;
        hold off;
    end
end