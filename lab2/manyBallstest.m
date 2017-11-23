a = [1:.5:10, inf];
colors = {'red', 'black'};
colors = repmat(colors, 1, 10);
colors{21} = 'b';
edges = {'green', 'white', 'None', 'yellow', 'cyan'};
edges = repmat(edges, 1, 4);
edges{21} = 'yellow';
drawManyBalls(a, colors, edges);
