d = load('Ellipse.mat');

phi = [d.xn.^2, d.yn.^2, d.yn.*d.xn, ones(1, d.N)];
plot(d.yn)
%plot(d.xn, d.yn, '.');