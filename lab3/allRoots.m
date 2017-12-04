function x = allRoots(f, n, k, xmin, xmax)
    moe = 10E-6;
    Fmoe = 100 .* moe;
    opts = optimset('TolFun', Fmoe, 'TolX', moe);
    F = @(x) abs(f(x));
    n_vertex = 2^k;
    step = 10;
    d = 0:(n_vertex - 1);
    b = fliplr(de2bi(d));
    b(find(b == 0)) = xmin;
    b(find(b == 1)) = xmax;
    n_directions = n_vertex * (n_vertex - 1) / 2;
    v = repmat(zeros(1, step * n_directions), k, 1).';
    for i = 2 : n_vertex
        for j = 1 : i - 1
            for m = 1 : k
                v((1 + step * (j - 1)) : ((j) * step), m) = linspace(b(j,m), b(i,m), step);
            end
        end
    end
    roots = NaN(n,k);
    q = 1;
    ind = 1;
    n_finded = 0;
    while (ind < size(v,1) && n_finded < n)
        x0 = v(ind, :);
        x_min = fminsearch(F, x0, opts);        
        if (q == 1)
            if (sum(repmat(xmin, 1, k) <= x_min) == k) && (sum(x_min <= repmat(xmax, 1, k)) == k)
                roots(q,:) = x_min;
                n_finded = q;
                q = q + 1;
            end
        elseif (~isempty(find(sum(abs(roots - repmat(x_min, n, 1)) <= moe) == 0, 1))...
                && ~isnan(x_min(1)))
            if (sum(repmat(xmin, 1, k) <= x_min) == k) && (sum(x_min <= repmat(xmax, 1, k)) == k)
                roots(q,:) = x_min;
                n_finded = q;
                q = q + 1;
            end
        end
        ind = ind + 1;
    end
    [ind_special, ~] = find(~isnan(roots(:,1)));
    x = roots(ind_special, :);
    dim = size(x,1);
    if (dim ~= 0) 
        msg = 'Found roots: ';
        disp(msg);
        for i = 1 : dim
            msg = ['x', num2str(i), ' = ', num2str(x(i,:))];
            disp(msg);
        end
        msg = 'Values: ';
        disp(msg);
        for i = 1 : dim
            msg = ['f(x', num2str(i), ') = ', num2str(f(x(i,:)))];
            disp(msg);
        end
    else
        disp('No roots found!');
    end
end