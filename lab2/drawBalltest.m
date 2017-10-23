%%
h = axes();
daspect([1,1,1]);
view(3);
axis tight
camlight 
lighting flat
s = struct('color', '', 'edgecolor', '', 'N', 0, 'axes_handler', 0);
s.axes_handler = h;
s.color = 'red';
s.edgecolor = 'black';
s.N = 100;
drawBall(inf,s);
%%

a = [2:20, inf];
drawManyBalls(a,'red','black');
%%
f = @(X, Y, Z) (X.^2 + Y.^2 + Z.^2);

[X,Y,Z] = meshgrid(-5:0.1:5);
V = f(X, Y, Z);

isosurface(X, Y, Z, V, 1)

%%
[x,y,z,v] = flow;
%[x,y,z] = flow;
%v = @(x,y,z) x^2+y^2+z^2;
%v = x.^2+y.^+2.^z;
p = patch(isosurface(x,y,z,v,-3));
%isonormals(x,y,z,v,p);
p.FaceColor = 'red';
p.EdgeColor = 'black';
daspect([1,1,1]);
view(3); axis tight
camlight 
lighting gouraud