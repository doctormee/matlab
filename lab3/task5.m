%% numero cinq
clc
clear variables;
N = 10000;
% eps = .01;
f = @(x) (x ~= 0) .* (x .* sin(1 ./ x)) + 0 .* x .* (x == 0);
lsp = linspace(-1, 1, N);
figure
for i = 1:N
    root(i) = fzero(f, lsp(i));
    if (i > 3)
%         if ( (abs(root(i - 1) - root(i - 2)) > eps) && (abs(root(i) - root(i - 1)) > eps) )
%             root(i - 1) = root(i - 2);
%         end
        [~, val] = findpeaks(root); 
        root(val) = root(val - 1); 
        [~, val] = findpeaks(-root); 
        root(val) = root(val - 1); 
    end
end
% plot(lsp, f(lsp))
% hold on;
% acc = 300;
% for i = 1 : acc
%     
% end;
stairs(lsp, root);
grid on;
xlabel('Estimation');
ylabel('Root');