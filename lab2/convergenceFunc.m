function [] = convergenceFunc( fn, f, a, b, n, convType )
%CONVERGENCEFUNC ? makes a convergence animation
%   convType must be one of three: 'Point', 'Square' or 'Uniform'
    size = 100;
    %mov(1:n) = struct('cdata', [], 'colormap', []);
    x = linspace(a, b, size);
    if (strcmp(convType, 'Point'))
        for i = 1:n
            plot(x, fn(x, i), x, f(x));
            info = strcat('Step', ' ', num2str(i));
            title(info);
            legend('fn', 'f');
            xlabel('x');
            ylabel('y');
%             getframe();
            mov(i) = getframe();
        end;
    else
        if (strcmp(convType, 'Square'))
            p = 2;
        else if (~strcmp(convType, 'Uniform'))
                disp('Error, wrong convType!');
                return;
            else
                p = inf;
            end
        end
        for i = 1:n
            plot(x, fn(x, i), x, f(x));
            info = ['Norm of difference: ' num2str(norm(fn(x, i) - f(x), p)) ' step' num2str(i)];
            title(info);
            legend('fn', 'f');
            xlabel('x');
            ylabel('y');
%             getframe();
            mov(i) = getframe();
        end;
    end
    movie(mov);
end

