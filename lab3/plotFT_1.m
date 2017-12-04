function res = plotFT_1(hFigure, fHandle, fFTHandle, step, inpLimVec, outLimVec)
    res = struct('nPoints', [], 'Step', []);
    
    
    n = (inpLimVec(2) - inpLimVec(1)) / step + 1; % delta/(step + 1) floored
    n = floor(n);
    
    res.nPoints = n;
    res.Step = (inpLimVec(2) - inpLimVec(1)) / (n - 1);
    
    x = linspace(inpLimVec(1), inpLimVec(2), n);
%   x = linspace(inpLimVec(1), inpLimVec(2), 10);
%   x = linspace(inpLimVec(1), inpLimVec(2), n/2);

    f = fHandle(x);
    
    Fast_fourier_manual_perfomance = res.Step .* fftshift(fft(f));
    
    x = linspace(0, 2*pi/res.Step, n);
    
    x = x - x(floor(n/2) + 1);  %shift to implement [-a;a] approach
                                %shift to the left to make it symmetric    
    
    Fast_fourier_manual_perfomance = Fast_fourier_manual_perfomance .* exp(-1i.*x.*inpLimVec(1)); 
                                % just a common Fourier transform
    
    SPlotInfo = get(hFigure, 'UserData');
    
    if size(SPlotInfo) == size([])
        if sum(size(outLimVec)) == 0
            g = [0 0];
            for i = 1:n
                if abs(Fast_fourier_manual_perfomance(i)) > 0.0001
                    if g(1) == 0
                        g(1) = i;
                    end
                    g(2) = i;
                end
            end
            g
            outLimVec = [x(g(1)), x(g(2))];
        end
        
        clf(hFigure); %clear figure window
        
        axRe = subplot(2, 1, 1);
        set(axRe, 'XLim', outLimVec);
        axRe.Title.String = 'Real part of fft';
        axRe.XLabel.String = 'Lambda - result variable';
        axRe.YLabel.String = 'Fourier Transform function';
        
        axIm = subplot(2, 1, 2);
        set(axIm, 'XLim', outLimVec);
        axIm.Title.String = 'Imaginary part of fft';
        axIm.XLabel.String = 'Lambda - result variable';
        axIm.YLabel.String = 'Fourier Transform function';
        
        SPlotInfo = struct('axRe', axRe, 'axIm', axIm);
    end
    
    if sum(size(outLimVec)) == 0
        
        axRe = SPlotInfo.axRe; % 
        outLimVec = get(axRe, 'xLim');
    else
        
        set(SPlotInfo.axRe, 'XLim', outLimVec);
        set(SPlotInfo.axIm, 'XLim', outLimVec);
    end
    set(hFigure, 'UserData', SPlotInfo);
    res.inpLimVec = inpLimVec;
    res.outLimVec = outLimVec;

    t = x - outLimVec(1);
    t = t(2:end).*t(1:end-1);
    FindMinima = find(t<=0);
    t = x - outLimVec(2);
    t = t(2:end).*t(1:end-1);
    FindMaxima = find(t<=0);
    
%     OutIndex = (outLimVec(1) < x) & (x < outLimVec(2));
%     if isempty(find(OutIndex, 1))
%         OutIndex = ones(1, n);
%     end
%     x = x(OutIndex);
    
    x = x(FindMinima:FindMaxima);
    Fast_fourier_manual_perfomance = Fast_fourier_manual_perfomance(FindMinima:FindMaxima);
%     Fast_fourier_manual_perfomance = Fast_fourier_manual_perfomance(x(:));
    
    % graphs time
    hFigure.CurrentAxes = SPlotInfo.axRe;
    hFigure.CurrentAxes.NextPlot = 'replacechildren';
    plot(x, real(Fast_fourier_manual_perfomance), 'Color', [0 0 0]); 
    legend('Re fft');
     
    if size(fFTHandle) ~= size([]) 
        hFigure.CurrentAxes.NextPlot = 'add';
        plot(x, real(fFTHandle(x)), 'r');
        legend('Re fft', 'Re manual-fft');
    end

    hFigure.CurrentAxes = SPlotInfo.axIm;
    axis tight;
    hFigure.CurrentAxes.NextPlot = 'replacechildren';
    plot(x, imag(Fast_fourier_manual_perfomance), 'Color', [0 0 0]);
    legend('Im fft');
    
    if size(fFTHandle) ~= size([])
        hFigure.CurrentAxes.NextPlot = 'add';
        plot(x, imag(fFTHandle(x)), 'r');
        legend('Im fft', 'Im manual-fft');
    end
end