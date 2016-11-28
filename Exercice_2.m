d = load('Ellipse.mat');

% State the phi matrix
phi = [d.xn'.^2 , d.yn'.^2 , d.xn', d.yn', d.xn'.*d.yn'];
%plot(d.yn)
%plot(d.xn, d.yn, '.');

% Compute the theta coef
theta = (phi' * phi)^-1 * phi' * ones(1, d.N)';

a = ones(d.N,1)*theta(2);
b = ones(d.N,1)*theta(4) + theta(5)*d.xn';
c = theta(1) * d.xn'.^2 + theta(3)*d.xn' - ones(d.N,1);
Delta = b.^2 - 4.*a.*c;

yoptp = (-b + sqrt(Delta))./(2*a);  %val pos 

yoptn = (-b - sqrt(Delta))./(2*a);  %val neg


plot(d.xn, d.yn, 'x', d.xn, yoptp, '.r', d.xn, yoptn, '.r')


