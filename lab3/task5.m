%% numero cinq
clc
clear variables;
N = 20000;
left = -1;  
right = 1; 
f = @(x) (x ~= 0) .* (x .* sin(1 ./ x)) + 0 .* x .* (x == 0);
% f = @(x) sqrt(abs(x)) .* sin(1./x) .* (x ~= 0) + 0 .* x .* (x == 0);
lsp = linspace(left, right, N);
figure
close = .00001;
Ind = 0;
for i = 1:N
    root(i) = fzero(f, lsp(i));
%     if (i > 3)
% %         if ( (abs(root(i - 1) - root(i - 2)) > eps) && (abs(root(i) - root(i - 1)) > eps) )
% %             root(i - 1) = root(i - 2);
% %         end
% %         [~, val] = findpeaks(root); 
% %         root(val) = root(val - 1); 
% %         [~, val] = findpeaks(-root); 
% %         root(val) = root(val - 1); 
%     end
%     if ((i > 1) && (abs(root(i) - root(i - 1)) < close))
%         clear Ind;
%         Ind = find(abs(root - root(i - 1)) < close, 1);
% %         root(Ind:i - 1) = root(i - 1);
%     end
end
% plot(lsp, f(lsp))
% hold on;
[lsp, root] = stairs(lsp, root);
for i = 2:(numel(root) / 2)
        clear Indl Indr;
        Indl = find(abs(root - root(i - 1)) < close, 1);
        root(Indl:i - 1) = root(i - 1);
        Indr = find(abs(root - root(numel(root) - i + 1)) < close, 1, 'last');
        root((numel(root) - i + 1):Indr) = root(numel(root) - i + 1);
end
plot(lsp, root);
grid on;
xlabel('Estimation');
ylabel('Root');
title('Fzero roots for function on [-1 1]');