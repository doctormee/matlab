function [] = plotter( time, mass, velocity, control, times )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    time = time.';
    splitSize = size(time, 2);
    figure;
    plot(time, velocity);
     figure;
    plot(time, mass);
    figure;
    controlVect = zeros(splitSize, 1);
    i = 1;
    j = 1;
    while (j < size(control, 1))
        while (time(i) < times(j))
            controlVect(i) = control(j);
            i = i + 1;
        end;
        j = j + 1;
    end;
    controlVect(i:end) = repmat(control(end), splitSize - i + 1, 1);
    plot(time, controlVect);
end

