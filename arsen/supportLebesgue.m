function rho = supportLebesgue(f, opts)
    function [c, ceq] = nonlcon(x)
        c = f(x);
        ceq = [];
    end
    function [fx, x] = body(dir)
        [x, fx] = fmincon(@ (x) - dot(dir, x) , [0,0], [], [], [], [], [], [], @nonlcon, opts);
        fx = -fx;
    end
    rho = @body;
end

