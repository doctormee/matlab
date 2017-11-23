%%

clc;
s = getParam('green', 'blue', 10, 1)
drawBall(inf,s);

%%

clc;
alpha = [2, 5 , 15, 6:12, inf];
colors = {'none', 'g'}
edgecolors = {'k', 'b', 'g', 'none'};
drawManyBalls(alpha, colors, edgecolors);

