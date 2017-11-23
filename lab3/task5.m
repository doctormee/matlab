%% numero cinq
clc
clear variables;
N = 500;
f = @(x) (x ~= 0) .* (x .* sin(1 ./ x)) + 0 .* x .* (x == 0);
lsp = linspace(-1, 1, N);
figure
for i = 1:N
    root(i) = fzero(f, lsp(i));
end
% plot(lsp, f(lsp))
% hold on;
stairs(lsp, root);
grid on;
xlabel('Estimation');
ylabel('Root');