% -------------------------------------------------------------------
%  Generated by MATLAB on 28-Sep-2016 10:32:14
%  MATLAB version: 9.1.0.441655 (R2016b)
% -------------------------------------------------------------------
d = load('Regression1.mat');

% Make the phi matrix
phi1 = ones(1, d.N);
phi2 = d.t;
phi3 = cos(2*pi * d.F1  *d.t);
phi4 = sin(2*pi * d.F1 * d.t);
phi = [phi1', phi2', phi3', phi4'];

% Compute the theta coef
theta = (phi' * phi)^-1 * phi' * d.xn';

% Compute de aproximate function
xn_aprox = phi * theta;

% Compute the error
mse = xn_aprox - d.xn';

err = dot(xn_aprox, mse');

snr = 10*log10(norm(xn_aprox)/norm(d.xn));

% Show
plot(d.t(1:1000), xn_aprox(1:1000), d.t(1:1000), d.xn(1:1000), d.t(1:1000), mse(1:1000))

