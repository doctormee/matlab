%% numero quatre
clc
f1 = @(x) cos(x);
f2 = @(x) x./pi;
f = @(x) f1(x) - f2(x);
lsp = -10:0.05:10;
figure
plot(lsp, f1(lsp), lsp, f2(lsp));
hold on;
grid on;
[pzero ~] = ginput;
for i = 1:numel(pzero)
    fzero(f, pzero(i))
end;
% [left ~] = ginput(1);
% [right ~] = ginput(1);
% fzero(f, [left right])