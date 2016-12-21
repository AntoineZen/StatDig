%% Problem definition

A = 1; % Signal amplitude
f = .8; % Signal frequency
w = .1; % Noise variance
N = 64; % Sample size

Nr = 16;

NFFT = 64; 
w_pis = linspace(0, 2*pi, NFFT);
for i = 1:Nr
    %% Create the signal
    x_n(i,:) = A*sin(2*pi*f*(1:N)) + w*randn(1,N);
    
    %% Do the pissarenco
    [Vmin, rho] = phd(x_n(i,:), 2);
    H = fft(Vmin, NFFT)*NFFT/2;
    X_pis(:, i) = 1./abs(H).^2;
end

figure;
hold on
for i = 1:Nr
    plot(w_pis(1:NFFT/2), X_pis(1:NFFT/2,i))
end
    



