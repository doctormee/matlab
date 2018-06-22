function reachsetdyn(alpha, t1, t2, N, filename, K, Kimp, dist, plotTr, maxRadius)

mov(N) = struct('cdata', [], 'colormap', []);
test = true;
acc = 0.01;
if test
    plot(0, 0, 'ob');
    hold on;
    grid on;
    flag = 1;
else
   flag = 0;
end
[X_max, Y_max] = reachset(alpha, t2, K, flag, dist, Kimp, maxRadius);

figure;
for i = 0 : N

    plot(0, 0, 'ob');
    hold on;
    grid on;
    axis([min(X_max) - acc, max(X_max) + acc, min(Y_max) - acc, max(Y_max) + acc]);

    t_cur = t1 + (t2 - t1) * i / N;
    [X, Y] = reachset(alpha, t_cur, K, plotTr, dist, Kimp, maxRadius); %* (i + 1) / N
    
    plot(X, Y, 'b', 'LineWidth', 1.7);
    
    mov(i + 1) = getframe;
    clf;
end

hold off;

if (isempty(filename))
    times = 5;   
    fps = 5;    
    movie(mov, times, fps);
else
    video_object = VideoWriter(strcat(filename, '.avi'));
    open(video_object);
    writeVideo(video_object, mov);
    close(video_object);
end

end