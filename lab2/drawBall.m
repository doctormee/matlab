function drawBall(alpha, params)
    axes(params.axes_handler);
    left = -5;
    right = 5;
    h = (right - left) ./ params.N;
    if alpha <= 0 
        disp('Incorrect input!');
        return;
    else
        if alpha == inf
            f = @(x,y,z) (max(max(abs(x), abs(y)), abs(z)));
            [X,Y,Z] = meshgrid(left:h:right);
            V = f(X, Y, Z);
            isovalue = 1;
            p = patch(isosurface(X, Y, Z, V, isovalue));
            p.FaceColor = params.color;
            p.EdgeColor = params.edgecolor;
        else
            if (alpha > 0) && (alpha < 1)
                f = @(X, Y, Z) (abs(X).^alpha + abs(Y).^alpha + abs(Z).^alpha);
                [X,Y,Z] = meshgrid(left:h:right);
                V = f(X, Y, Z);
                %isovalue = rand(min(V),max(V));
                %isovalue = 1;
                minF = min(V(:));
                maxF = max(V(:));
                isovalue = 1;
                p = patch(isosurface(X, Y, Z, V, isovalue));
                p.FaceColor = params.color;
                p.EdgeColor = params.edgecolor;
            else
                f = @(X, Y, Z) (abs(X).^alpha + abs(Y).^alpha + abs(Z).^alpha);
                [X,Y,Z] = meshgrid(left:h:right);
                V = f(X, Y, Z);
                %isovalue = rand(min(V),max(V));
                %minF = min(V(:));
                %maxF = max(V(:));
                isovalue = 1;
                p = patch(isosurface(X, Y, Z, V, isovalue));
                p.FaceColor = params.color;
                p.EdgeColor = params.edgecolor;
            end
        end
    end
end