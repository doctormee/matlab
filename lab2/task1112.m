%% function (exp)
func = @(X, Y, A) A .* X .* exp(-X .^ 2 - Y .^ 2);
%% function peaks
clear func;
func = @(X, Y, A) A .* peaks(X, Y);

%% function smth
clear func;
func = @(X, Y, A) (A .* X .^ 2 + Y .^ 2);
%% doin stuff
clear anim;
left = -2;
right = 2;
range = left:0.1:right;
aMin = 1;
aMax = 10;
aStep = .5;
pTime = .01;
eps = 1;
[X Y] = meshgrid(range, range);
frameNumber = (aMax - aMin) ./ aStep;
maxFunc = func(X, Y, aMax);
[zMin ~] = min(maxFunc(:));
zMin = zMin - eps;
[zMax ~] = max(maxFunc(:));
zMax = zMax + eps;
anim(frameNumber) = struct('cdata', [], 'colormap', [1  1  0; 0  1  1]);
for i = 1:frameNumber
    A = aMin + aStep .* i;
    Z = func(X, Y, A);
    surf(X, Y, Z);
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
    
    A = 10;
    height = 0;
    z = func(X, Y, A);
    contour(z, [height height]);
%%  saving animation as a video file
    clc
    save('evolution.mat', 'anim');
    vidObj = VideoWriter('evolution.avi');
    open(vidObj);
    writeVideo(vidObj,anim);
    close(vidObj);
