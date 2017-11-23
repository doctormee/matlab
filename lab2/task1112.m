%% function 
func = @(X, Y, A) A .* sin(X) + sin(Y);
%% function peaks
clear func;
func = @(X, Y, A) A .* peaks(X, Y);

%% function smth
clear func;
func = @(X, Y, A) (A .* X .^ 2 + A .* Y .^ 2);

%% doin stuff
clear anim;
view(3);
left = -2;
right = 2;
rStep = 0.1;
range = left:rStep:right;
length = (right - left) ./ rStep;
aMin = 1;
aMax = 10;
aStep = .1;
pTime = .01;
eps = 1;
[X Y] = meshgrid(range, range);
frameNumber = (aMax - aMin) ./ aStep;
maxFunc = func(X, Y, aMax);
[zMin ~] = min(maxFunc(:));
zMin = zMin - eps;
[zMax ~] = max(maxFunc(:));
zMax = zMax + eps;
anim(frameNumber) = struct('cdata', [], 'colormap', []);
for i = 1:frameNumber
    A = aMin + aStep .* i;
    Z = func(X, Y, A);
    surf(X, Y, Z);
    hold on;
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    maxMat = zeros(size(Z, 1));
    minMat = zeros(size(Z, 1));
    for j = 2:(size(Z, 1) - 1)
        clear maxInd minInd;
        [~, maxInd] = findpeaks(Z(:, j));
        [~, minInd] = findpeaks(-Z(:, j));
        maxMat(j, maxInd) = (Z(j - 1, maxInd) < Z(j, maxInd)) ...
            .* (Z(j + 1, maxInd) < Z(j, maxInd));
        minMat(j, minInd) = (Z(j - 1, minInd) > Z(j, minInd)) ...
            .* (Z(j + 1, minInd) > Z(j, minInd));
    end
    clear maxRow maxCol minRow minCol;
    [maxRow, maxCol] = find(maxMat == 1);
    [minRow, minCol] = find(minMat == 1);
    plot3(X(1, minCol), Y(minRow, 1), Z(minRow, minCol), '*r');
    plot3(X(1, maxCol), Y(maxRow, 1), Z(maxRow, maxCol), '*g');
    hold off;
    axis([left right left right zMin zMax]);
    pause(pTime);
    anim(i) = getframe();
end
%% play animation
   clc 
   
   times = 3;                % amount of repeats
   frames_per_sec = 60;      % speed (fps)
   movie(anim, times, frames_per_sec);
%% building projection for a certain level onto OXY 
    clc
    
    A = aMax;
    height = 4;
    z = func(X, Y, A);
    contour(z, [height height]);
    grid on;
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    legend(['Contour on level ', num2str(height)]);
%%  saving animation as a video file
    clc
    save('evolution.mat', 'anim');
    vidObj = VideoWriter('evolution.avi');
    open(vidObj);
    writeVideo(vidObj,anim);
    close(vidObj);
