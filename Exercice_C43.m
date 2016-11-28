 
%% Create the input signal x_n
x_n = zeros(200, 1);
x_n(25) = 1;
x_n(40) = .8;
x_n(55) = .7
x_n(65) = .5;
x_n(85) = .7;
x_n(95) = .2;
x_n(110) = .9;
x_n(130) = .5;
x_n(140) = .6;
x_n(155) = .3;

%% Creat the blurier filter
n = 1:51;
g_n = cos(0.2.*(n-25)).*exp(-0.01.*(n-25).^2);
g_n(51) = 0;

%plot(g_n);

%% pass the signal trough the filter
y_n = conv(x_n, g_n, 'same');

%% Compute the inverse filter of g(n) e.g. g_n
[h_n, e] = spike(g_n, 25, 51)

%% De-blurie the signal to get the reconstructed one
x_hat = conv(y_n, h_n, 'same')

%% Plot
figure;
subplot(2, 1, 1);
plot(1:numel(x_n), x_n, 1:numel(y_n), y_n, 1:numel(x_hat), x_hat);

subplot(2, 2, 3)
plot(1:numel(g_n), g_n)
subplot(2, 2, 4)
plot(1:numel(h_n), h_n)


