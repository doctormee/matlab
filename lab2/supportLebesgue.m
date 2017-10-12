function [ ret ] = supportLebesgue( f, opts )
%supportLebesgue returns an approximate support function of X = {x: f(x) <= 0}, 
%   where f is f(x), x is 1x2 vector and opts are additional options for
%   optimization
    function [c, ceq] = nonlcon(x) 
        ceq = [];
        c = f(x);
    end
    function [val, point] = rho( dir )
        [point, val] = fmincon(@(x) -dot(dir, x) , ...
            [0, 0] ,[],[],[],[],[],[], @nonlcon , opts);
    end
    ret = @rho;
end
