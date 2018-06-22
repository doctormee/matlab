function [X, Y, switchesLine] = reachset(alpha, t, N, plot_traj, dist, K, maxRadius)

X = [];
Y = [];
pause_time = 0.0;
fzero_opt = optimset('Display', 'none');

switchesLine = [];

x2opts = odeset('Events', @(t, x) event_x_2(t, x, maxRadius), 'RelTol', 2.22045e-14);
psi2opts = odeset('Events', @(t, x) event_psi_2(t, x, maxRadius), 'RelTol', 2.22045e-14);

% system S+
[timesStartPlus, xStartPlus] = ode45(@(t, x) odefun_S_plus(t, x, alpha), [0, t], ...
    [0, 0], x2opts);
switchesLine = [switchesLine; xStartPlus];

if (N > 0)
    xStartPlusFun = @(t) interp1(timesStartPlus, xStartPlus, t, 'spline');
    timeSwitch = timesStartPlus(end);
    timeSplitting = linspace(0, timeSwitch, N);
%     timeSplitting = ones(1, N) * timeSwitch - fliplr((logspace(0, log10(timeSwitch), N) - 1));
    for i = 1 : N
        time = timeSplitting(i);
        curTraj = xStartPlusFun(timeSplitting(1 : i));
        while time < t
            [curTimes, curX] = ode45(@(t, x) odefun_S_minus_conj(t, x, alpha), ...
                [time, t], [curTraj(end, 1), curTraj(end, 2), 1, 0], ...
                psi2opts);

            curTraj = [curTraj; curX(2 : end, 1 : 2)];

            time = curTimes(end);
            if (time >= t) || (max(abs(curX(end, 1:2))) > maxRadius)
                break;
            end

            [curTimes, curX] = ode45(@(t, x) odefun_S_plus_conj(t, x, alpha), ...
                [time, t], [curTraj(end, 1), curTraj(end, 2), -1, 0], ...
                psi2opts);

            curTraj = [curTraj; curX(2 : end, 1 : 2)];

            time = curTimes(end);
            if (time < t)
                switchesLine = [switchesLine; curX(end, 1 : 2)];
            end
            if (time >= t) || (max(abs(curX(end, 1:2))) > maxRadius)
                break;
            end

        end

        
        if (plot_traj)
            plot(curTraj(:, 1), curTraj(:, 2), 'm');
            plot(curTraj(end, 1), curTraj(end, 2), '.b');
            pause(pause_time);
        end
        
        X = [X, curTraj(end, 1)];
        Y = [Y, curTraj(end, 2)];

    end
    while true
        i = 1;
        while true

            i = i + 1;

            cur_dist = norm([X(i) - X(i - 1), Y(i) - Y(i - 1)]);

            if (cur_dist > dist)

                X_cur = [];
                Y_cur = [];

                t1_cur = timeSplitting(i - 1);
                t2_cur = timeSplitting(i);

                timeSplittingCur = linspace(t1_cur, t2_cur, K + 2);

                for iCur = 2 : K + 1
                    time = timeSplittingCur(iCur);
                    curTraj = xStartPlusFun(timeSplittingCur(1 : iCur));
                    while time < t
                        [curTimes, curX] = ode45(@(t, x) odefun_S_minus_conj(t, x, alpha), ...
                            [time, t], [curTraj(end, 1), curTraj(end, 2), 1, 0], ...
                            psi2opts);

                        curTraj = [curTraj; curX(2 : end, 1 : 2)];

                        time = curTimes(end);
                        if (time >= t) || (max(abs(curX(end, 1:2))) > maxRadius)
                            break;
                        end

                        [curTimes, curX] = ode45(@(t, x) odefun_S_plus_conj(t, x, alpha), ...
                            [time, t], [curTraj(end, 1), curTraj(end, 2), -1, 0], ...
                            psi2opts);

                        curTraj = [curTraj; curX(2 : end, 1 : 2)];

                        time = curTimes(end);

                        if (time < t)
                            switchesLine = [switchesLine; curX(end, 1 : 2)];
                        end
                        if (time >= t) || (max(abs(curX(end, 1:2))) > maxRadius)
                            break;
                        end

                    end


                    if (plot_traj)
                        plot(curTraj(:, 1), curTraj(:, 2), 'm');
                        plot(curTraj(end, 1), curTraj(end, 2), '.b');
                        pause(pause_time);
                    end

                    X_cur = [X_cur; curTraj(end, 1)];
                    Y_cur = [Y_cur; curTraj(end, 2)];
                end

                X = [X(1 : (i - 1)), X_cur.', X(i : end)];
                Y = [Y(1 : (i - 1)), Y_cur.', Y(i : end)];
                timeSplitting = [timeSplitting(1 : (i - 1)), ...
                    timeSplittingCur(2:K+1), timeSplitting(i : end)];
                break;
            end

            if (i >= length(X))
                break;
            end

        end
        if i >= length(X) 
            break;
        end
    end
end
X = [X, NaN];
Y = [Y, NaN];

[timesStartMinus, xStartMinus] = ode45(@(t, x) odefun_S_minus(t, x, alpha), [0, t], ...
    [0, 0], x2opts);

switchesLine = [switchesLine; xStartMinus];

if (N > 0)
    
    X_minus = [];
    Y_minus = [];

    x_start_minus_fun = @(t) interp1(timesStartMinus, xStartMinus, t, 'spline');

    timeSwitch = timesStartMinus(end);
    timeSplitting = linspace(0, timeSwitch, N);
%     timeSplitting = (logspace(0, log10(timeSwitch), N) - 1);

    for i = 1 : N
        time = timeSplitting(i);
        curTraj = x_start_minus_fun(timeSplitting(1 : i));
        while time < t
            if max(abs(curTraj(end, :))) >= maxRadius
               break;
            end
            [curTimes, curX] = ode45(@(t, x) odefun_S_plus_conj(t, x, alpha), ...
                [time, t], [curTraj(end, 1), curTraj(end, 2), -1, 0], ...
                psi2opts);

            curTraj = [curTraj; curX(2 : end, 1 : 2)];

            time = curTimes(end);
            if (time >= t) || (max(abs(curX(end, 1:2))) > maxRadius)
                break;
            end

            [curTimes, curX] = ode45(@(t, x) odefun_S_minus_conj(t, x, alpha), ...
                [time, t], [curTraj(end, 1), curTraj(end, 2), 1, 0], ...
                psi2opts);

            curTraj = [curTraj; curX(2 : end, 1 : 2)];

            time = curTimes(end);
            
            if (time < t)
                switchesLine = [switchesLine; curX(end, 1 : 2)];
            end
            if (time >= t) || (max(abs(curX(end, 1:2))) > maxRadius)
                break;
            end

        end


        if (plot_traj)
            plot(curTraj(:, 1), curTraj(:, 2), 'g');
            plot(curTraj(end, 1), curTraj(end, 2), '.b');
            pause(pause_time);
        end
        
        X_minus = [X_minus, curTraj(end, 1)];
        Y_minus = [Y_minus, curTraj(end, 2)];

    end
    while true
        i = 1;
        while true

            i = i + 1;

            cur_dist = norm([X_minus(i) - X_minus(i - 1), Y_minus(i) - Y_minus(i - 1)]);

            if (cur_dist > dist) && ((timeSplitting(i) - timeSplitting(i - 1)) > 1e-7)

                X_cur = [];
                Y_cur = [];
                t1_cur = timeSplitting(i - 1);
                t2_cur = timeSplitting(i);
                timeSplittingCur = linspace(t1_cur, t2_cur, K + 2);
                for iCur = 2 : K + 1
                    time = timeSplittingCur(iCur);
                    curTraj = x_start_minus_fun(timeSplittingCur(1 : iCur));
                    while time < t
                        if max(abs(curTraj(end, :))) >= maxRadius
                           break;
                        end
                        [curTimes, curX] = ode45(@(t, x) odefun_S_plus_conj(t, x, alpha), ...
                            [time, t], [curTraj(end, 1), curTraj(end, 2), -1, 0], ...
                            psi2opts);
                        curTraj = [curTraj; curX(2 : end, 1 : 2)];
                        time = curTimes(end);
                        if (time >= t) || (max(abs(curX(end, 1:2))) > maxRadius)
                            break;
                        end
                        [curTimes, curX] = ode45(@(t, x) odefun_S_minus_conj(t, x, alpha), ...
                            [time, t], [curTraj(end, 1), curTraj(end, 2), 1, 0], ...
                            psi2opts);
                        curTraj = [curTraj; curX(2 : end, 1 : 2)];
                        time = curTimes(end);
                        if (time < t)
                            switchesLine = [switchesLine; curX(end, 1 : 2)];
                        end
                        if (time >= t) || (max(abs(curX(end, 1:2))) > maxRadius)
                            break;
                        end
                    end
                    if (plot_traj)
                        plot(curTraj(:, 1), curTraj(:, 2), 'g');
                        plot(curTraj(end, 1), curTraj(end, 2), '.b');
                        pause(pause_time);
                    end
                    X_cur = [X_cur; curTraj(end, 1)];
                    Y_cur = [Y_cur; curTraj(end, 2)];
                end
                X_minus = [X_minus(1 : (i - 1)), X_cur.', X_minus(i : end)];
                Y_minus = [Y_minus(1 : (i - 1)), Y_cur.', Y_minus(i : end)];
                timeSplitting = [timeSplitting(1 : (i - 1)), ...
                    timeSplittingCur(2:K+1), timeSplitting(i : end)];
                break;
            end
            if (i == length(X_minus))
                break;
            end
        end
        if i == length(X_minus) 
            break;
        end
    end
    X = [X, X_minus];
    Y = [Y, Y_minus];
end

x2Spec = 0;
funcSpec1 = @(x1) atan(x1^2) - alpha - cos(x1^2)*x1^2;
funcSpec2 = @(x1) atan(x1^2) + alpha - cos(x1^2)*x1^2;
x1min = min(X);
x1max = max(X);

x1split = linspace(x1min, x1max, N);

for x1cur0 = x1split
    x1zero = fzero(funcSpec1, x1cur0, fzero_opt);
    if ((x1zero <= x1max) && (x1zero >= x1min))
        plot(x1zero, x2Spec, 'om', 'LineWidth', 2);
    end
end

for x1cur0 = x1split
    x1zero = fzero(funcSpec2, x1cur0, fzero_opt);
    if ((x1zero <= x1max) && (x1zero >= x1min))
        plot(x1zero, x2Spec, 'og', 'LineWidth', 2);
    end
% end
% [X, Y] = delete_cross(X, Y);
% X = [X, X(1)];
% Y = [Y, Y(1)];
end