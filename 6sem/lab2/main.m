k = 20;
l = 100;
m0 = 300;
M = 220;
T = 1;
umin = 1;
umax = 100;
g = 10;
moe = 10e-2;
% dydt = @(t, y) sys1( t, y, g, l, k, u );
eventFcn = @(t, y) switch_func(t, y, l, M, -1./2);
opts = odeset('Events', eventFcn);


%% 
clc
clear h;
alphaSize = 200;
left_angle = 0;
right_angle = 2.*pi;
i = 1;
alphaSpace = [linspace(left_angle, right_angle, alphaSize), 0];
mass = cell(size(alphaSpace));
velocity = cell(size(alphaSpace));
switch_times = cell(size(alphaSpace));
time = cell(size(alphaSpace));
control = cell(size(alphaSpace));
%normal case
for alpha = alphaSpace
    psi10 = sin(alpha);
    psi20 = cos(alpha);
    if (alpha == 0)
        psi10 = 0;
        psi20 = 0;
    end;
    %starting conditions
    if (psi10 .*l - psi20.*m0  >= moe)
        u = umax;
    else
        u = umin;
    end;
    mass{i} = [];
    velocity{i} = [];
    switch_times{i} = [];
    control{i} = [];
    time{i} = [];
    % psi10 = sin(pi./2 + 0.2);
    % psi20 = cos(pi./2 + 0.2);
    [t, y, te, ye, ie] = ode45(@(t, y) full_sys1( t, y, g, l, k, u ),...
    [0, T], [0; m0; psi10; psi20], opts);
    func = @(t, y) full_sys1( t, y, g, l, k, u );
    flag = 1;
    while (abs(te - T) > moe)
        velocity{i} = [velocity{i}; y(:, 1)];
        mass{i} = [mass{i}; y(:, 2)];
        switch_times{i} = [switch_times{i}; te];
        control{i} = [control{i}; u];
        time{i} = [time{i}; t];
        if ((ie == 3) || (ie == 4))
            break;
        end;
        if (ie == 1)
            if (y(end, 3) .*l - y(end, 4).*y(end, 2)  >= moe)
                u = umax;
            else
                u = umin;
            end;
        end;
        if (ie == 2)
            flag = 2;
            u = 0;
        end;
        if (flag == 1)
            func = @(t, y) full_sys1( t, y, g, l, k, u );
        else
            func = @(t, y) full_sys2( t, y, g, l, k, u );
        end;
        [t, y, te, ye, ie] = ode45(@(t, y)func(t, y),...
        [te, T], [ye(end, 1); ye(end, 2); ye(end, 3); ye(end, 4)], opts);
    end;
    if ~isempty(ie) && ((ie == 3) || (ie == 4))
        h(i) = 0;
        continue;
    else
        velocity{i} = [velocity{i}; y(:, 1)];
        mass{i} = [mass{i}; y(:, 2)];
        switch_times{i} = [switch_times{i}; te];
        control{i} = [control{i}; u];
        time{i} = [time{i}; t];
    %     plot(t, y(:, 2), 'r');
        %      plot(t, y(:, 1), 'g');

        h(i) = trapz(velocity{i});
        i = i + 1;
    end
end
[maxHeight_normal, maxind] = max(h);
switch_normal = switch_times{maxind};
control_normal = control{maxind};
velocity_normal = velocity{maxind};
mass_normal = mass{maxind};
time_normal = time{maxind};
%anormal case
clear h;
i = 1;
alphaSpace = linspace(left_angle, right_angle, alphaSize);
mass = cell(size(alphaSpace));
velocity = cell(size(alphaSpace));
switch_times = cell(size(alphaSpace));
control = cell(size(alphaSpace));
time = cell(size(alphaSpace));
for alpha = alphaSpace
    psi10 = sin(alpha);
    psi20 = cos(alpha);
    %starting conditions
    if (psi10 .*l - psi20.*m0  >= moe)
        u = umax;
    else
        u = umin;
    end;
    mass{i} = [];
    velocity{i} = [];
    switch_times{i} = [];
    control{i} = [];
    time{i} = [];
    % psi10 = sin(pi./2 + 0.2);
    % psi20 = cos(pi./2 + 0.2);
    [t, y, te, ye, ie] = ode45(@(t, y) full_sys1_anorm( t, y, g, l, k, u ),...
    [0, T], [0; m0; psi10; psi20], opts);
    func = @(t, y) full_sys1_anorm( t, y, g, l, k, u );
    flag = 1;
    while (abs(te - T) > moe)
        velocity{i} = [velocity{i}; y(:, 1)];
        mass{i} = [mass{i}; y(:, 2)];
        switch_times{i} = [switch_times{i}; te];
        control{i} = [control{i}; u];
        time{i} = [time{i}; t];
        if ((ie == 3) || (ie == 4) || (ie == 5))
            break;
        end;
        if (ie == 1)
            if (y(end, 3) .*l - y(end, 4).*y(end, 2)  >= moe)
                u = umax;
            else
                u = umin;
            end;
        end;
        if (ie == 2)
            flag = 2;
            u = 0;
        end;
        if (flag == 1)
            func = @(t, y) full_sys1_anorm( t, y, g, l, k, u );
        else
            func = @(t, y) full_sys2_anorm( t, y, g, l, k, u );
        end;
        [t, y, te, ye, ie] = ode45(@(t, y)func(t, y),...
        [te, T], [ye(end, 1); ye(end, 2); ye(end, 3); ye(end, 4)], opts);
    end;
    if ~isempty(ie) && ((ie == 3) || (ie == 4) || (ie == 5))
        h(i) = 0;
        continue;
    else
        velocity{i} = [velocity{i}; y(:, 1)];
        mass{i} = [mass{i}; y(:, 2)];
        switch_times{i} = [switch_times{i}; te];
        control{i} = [control{i}; u];
        time{i} = [time{i}; t];

    %     plot(t, y(:, 2), 'r');
        %      plot(t, y(:, 1), 'g');

        h(i) = trapz(velocity{i});
        i = i + 1;
    end
end
[maxHeight_anormal, maxind] = max(h);
switch_anormal = switch_times{maxind};
control_anormal = control{maxind};
velocity_anormal = velocity{maxind};
time_anormal = time{maxind};
mass_anormal = mass{maxind};
% printing
if (maxHeight_normal >= maxHeight_anormal)
    disp(['Maximal height is: ', num2str(maxHeight_normal)]);
    plotter( time_normal, mass_normal, velocity_normal, control_normal, ...
        switch_normal );
else
    disp(['Maximal height is: ', num2str(maxHeight_anormal)]);
    plotter( time_anormal, mass_anormal, velocity_anormal, control_anormal, ...
        switch_anormal );
end;
%%
clear h;
clear norms;
clc
MAXH = 500;
MAX = 2000;
spsize = 100;
alphaSize = 500;
left_angle = 0;
right_angle = 2.*pi;
moe = 10;
i = 1;
eventFcn = @(t, y) switch_func(t, y, l, M, 1);
opts = odeset('Events', eventFcn);
alphaSpace = [linspace(left_angle, right_angle, alphaSize), 0];
cellSize = size(alphaSpace).*spsize;
mass = cell(cellSize);
velocity = cell(cellSize);
switch_times = cell(cellSize);
time = cell(cellSize);
control = cell(cellSize);
%normal case
for mas = linspace(1000, MAX, spsize)
for alpha = alphaSpace
    psi10 = mas.*sin(alpha);
    psi20 = mas.*cos(alpha);
    %starting conditions
    mass{i} = [];
    velocity{i} = [];
    switch_times{i} = [];
    control{i} = [];
    time{i} = [];
    u = 1./2 .* (-psi10.*(l) + psi20);
    if (u.*l <= m0.*g)
        continue;
    end;
    % psi10 = sin(pi./2 + 0.2);
    % psi20 = cos(pi./2 + 0.2);
    [t, y, te, ye, ie] = ode45(@(t, y) full_sys3( t, y, g, l, k, umin, umax ),...
    [0, T], [0; m0; psi10; psi20], opts);
    func = @(t, y) full_sys3( t, y, g, l, k, umin, umax );
    flag = 1;
    while (abs(te - T) > moe)
        velocity{i} = [velocity{i}; y(:, 1)];
        mass{i} = [mass{i}; y(:, 2)];
        switch_times{i} = [switch_times{i}; te];
        u = 1./2 .* (-y(:, 3).*(l + y(:, 1)) + y(:,4));
        u = (u < umin).*umin + umax.*(u > umax) + u.*(u >= umin).*(u <= umax);
        time{i} = [time{i}; t];
        if ((ie == 3) || (ie == 4))
            break;
        end;
        if (ie == 2)
            flag = 2;
            u = 0;
        end;
        if (flag == 1)
            func = @(t, y) full_sys3( t, y, g, l, k, umin, umax );
        else
            func = @(t, y) full_sys2( t, y, g, l, k, 1);
            sz = size(t);
            u = repmat(u, 1, sz(1));
        end;
        control{i} = [control{i}, u];
        [t, y, te, ye, ie] = ode45(@(t, y)func(t, y),...
        [te, T], [ye(end, 1); ye(end, 2); ye(end, 3); ye(end, 4)], opts);
    end;
    if ~isempty(ie) && ((ie == 3) || (ie == 4))
        h(i) = 0;
        continue;
    else
        velocity{i} = [velocity{i}; y(:, 1)];
        mass{i} = [mass{i}; y(:, 2)];
        switch_times{i} = [switch_times{i}; te];
         u = 1./2 .* (-y(:, 3).*(l + y(:, 1)) + y(:,4));
        u = (u < umin).*umin + umax.*(u > umax) + u.*(u >= umin).*(u <= umax);
        if (flag == 2)
            u = 0;
            sz = size(t);
            u = repmat(u, 1, sz(1));
        end;
        control{i} = [control{i}, u];
        time{i} = [time{i}; t];
        h(i) = trapz(velocity{i});
        norms(i) = trapz(control{i});
        if (abs(h(i) - MAXH) > moe)
            h(i) = 0;
            norms(i) = inf;
        else
            norms(i) = trapz(control{i});
        end;
    %     plot(t, y(:, 2), 'r');
        %      plot(t, y(:, 1), 'g');

        i = i + 1;
    end
end;
end;
[minNorm, minind] = min(norms);
disp(['Minimal norm is ', num2str(minNorm)]);
switch_normal = switch_times{minind};
control_normal = control{minind};
velocity_normal = velocity{minind};
mass_normal = mass{minind};
time_normal = time{minind};
time_normal = time_normal.';
figure;
plot(time_normal, velocity_normal);
figure;
plot(time_normal, mass_normal);
figure;
plot(time_normal, control_normal);
%%
[t, y, te, ye, ie] = ode45(@(t, y) sys1( t, y, g, l, k, u ),...
        [0, T], [0; m0; 0], opts);
if (abs(te - T) > moe)
    [t1, y1, te, ye, ie] = ode45(@(t, y) sys2( t, y, g, l, k, u ),...
    [te, T], [y(end, 1); y(end, 2); y(end, 3)], opts);
    plot([t; t1], [y(:, 3); y1(:, 3)], 'g');
else
    plot(t, y(:, 3), 'r');
end;
    

