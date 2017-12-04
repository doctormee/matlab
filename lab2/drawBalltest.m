%%
h = axes();
daspect([1,1,1]);
view(3);
axis tight
camlight 
lighting gouraud
s = struct('color', '', 'edgecolor', '', 'N', 0, 'axes_handler', 0);
s.axes_handler = h;
s.color = 'cyan';
s.edgecolor = 'none';
s.N = 100;
drawBall(inf,s);
% drawManyBalls(3, {'blue'}, {'black'});