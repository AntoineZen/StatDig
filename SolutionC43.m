%% C43.m

%% Init
clear
close all

%% Parameters
Ng = 51; % Length of the blurring filter
Nh = 51; % Length of the inverse filter
Nx = 181; % Length of the signal
n0g = 25; % Mean of the smoothing filter
SigmaG = 10; % Standard deviation of the smoothing filter
Choice = input ('Add some noise to the signal 0/1 : ')
if Choice == 0
    SigmaN = 0;
else
    SigmaN = 0.0004;
end;

%% Original signal
n = 0 : Nx-1;
x = zeros (size (n));
x ([25, 40, 55, 65, 85, 95, 110, 130, 140, 155]) = [1, 0.8, 0.7, 0.5, 0.7, 0.2, 0.9, 0.5, 0.6, 0.3];

%% Blurring filter
n = 1 : Ng;
g = cos (0.2*(n-n0g)).*exp (-(n-n0g).^2/SigmaG^2);
y = conv (x, g, 'same');
Ny = numel (y);

%% Noise bieng added
n = SigmaN * randn (size (y));
yn = y + n;

%% Inverse filter
err = zeros (1, Nh+Ng-1); % Nh + Ng - 1
for n0 = 0 : Nh+Ng-2
    [h(:, n0+1),err(n0+1)] = spike (g, n0, Nh);
end;
[MinErr, Ix] = min (err);
n0h = Ix - 1;
h = h (:, Ix-1);
dEst = conv (g, h);
xEst = conv (yn, h);

%% Display
n0y = n0h - n0g;
figure
subplot (3, 1, 1)
plot (0 : Nx-1, x, 'r', 1 : Nx, yn, 'g', 1 : Nx, xEst (n0y+1 : n0y + Nx), 'b'), axis tight, title (['x, x*g, n_{0y} = ', num2str(n0y), ', \sigma_G = ', num2str(SigmaG), ', \sigma_N = ', num2str(SigmaN)])
subplot (3, 2, 3)
plot (1 : Ng, g), axis tight, title (['g, N_g = ', num2str(Ng)])
subplot (3, 2, 4)
plot (1 : Nh, h), axis tight, title (['h, N_h = ', num2str(Nh)])
subplot (3, 2, 5)
plot (1 : Ng + Nh - 1, dEst), axis tight, title (['g*h, n_0 = ', num2str(n0h)]), vline (n0h);
subplot (3, 2, 6)
plot (err), axis tight, xlabel ('n_0'), title ('\epsilon(n_0)'), vline (n0h);

%% Print 2 file
if Choice == 0
    print ('-f1', '-dpng', ['C43SigmaG',num2str(SigmaG),'NoNoise.png'])
else
    print ('-f1', '-dpng', ['C43SigmaG',num2str(SigmaG),'Noise.png'])
end;