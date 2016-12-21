% Computer exerise 1 
% Decunvolution of  a system
% Maurizio Tognolini  16.01.2009
% HEIG-VD  MSE  Zurich
clear all;
close all;clc;

Fig=1;

%% Input signal definition
N = 50;
n = (1:1:N);
omega0 = 0.2;
x = sin(omega0*n);

%% System definition
h= [1,2,3];
o = length(h);   %order of the system




%% Noiseless Output signal computation
y= conv(x,h);


%% Noisy output
Namp=0.0001;
noise= Namp*randn(1,N+o-1);
yn = y+noise;


%% Noiseless deconvolution

[xd, rd] = deconv(y,h);

%% Deconvolution with noise
[xdn, rdn] = deconv(yn,h);


%% Plots
figure (Fig);
Fig = Fig+1;
subplot(2,2,1);
plot(n,x,'.r');
axis([1,N,-1,1])
xlabel('n')
title('Input signal')

subplot(2,2,2);
plot(n,y(1:N),'.b');
axis([1,N,min(y),max(y)])
title('Output signal with h = [1,2,3]')
xlabel('n')

subplot(2,2,3);
plot(n,xd(1:N),'.r',n,x(1:N),'og',n,xdn(1:N),'*b');
axis([1,N,-1,1])
xlabel('n')
title('Input signal compared to deconvolution result with noise and without noise')
legend('Deconvolution no noise', 'Original Input signal', 'Deconvolution with noise')

subplot(2,2,4);
plot(n,yn(1:N),'.r',n,y(1:N),'og');
axis([1,N,-10,10])
xlabel('n')
title('Output signals  with and without noise')
legend('Out with noise', 'Out without noise')

figure(Fig);
Fig = Fig+1;

%subplot(2,2,3);
plot(n,xdn(1:N),'*b');
axis([1,N,-1,1])
xlabel('n')
title('Input signal computed  by deconvolution')

