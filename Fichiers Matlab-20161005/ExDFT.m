% Exemple de la DTFT  sur  des  signaux  a duree finie   avec  et  sans
% zero padding  ainsi que  sur un signaux  périodique.
% M.Tognolini
 %23.02.2011

clear all
close all

clc


% cas 1  avec 10 points 1 pŽriode de sinus
N1 =20;
k1 = (0:N1-1);
x1 = [ones(1,round(N1/2)) , zeros(1,N1 - round(N1/2))];
Ex1 = x1 * x1'
mx1 = mean(x1)
X1 = 1/Ex1*fftshift(fft(x1));
f1 = (-1/2):1/N1:(1/2-1/N1);
EX1 = sum(abs(X1).^2)

%expression de lA DTFT THéORIQUE

Nth = 100*N1;
fth = (-1/2): 1/Nth :(1/2-1/Nth);

F = [exp(j*2*pi*fth'*k1)];
Xth = (x1 * F')/Ex1;


%cas 2   avec zŽro padding (90 zeros ajoutŽs)
N2 =100;
k2 = (0:N2-1);
x2 = zeros(1,N2);
x2(1:N1) = [ones(1,round(N1/2)), zeros(1,N1 - round(N1/2))];
Ex2 = x2 * x2'
mx2 = mean(x2)
X2 = 1/Ex2*fftshift(fft(x2));
f2 = (-1/2):1/N2:(1/2-1/N2);
EX2 = X2*X2'

% Exemple sinus tronqué

N3 =50;
k3 = (0:N3-1);
Tsin =12; 
x3 = sin(2*pi*k3/Tsin);
Ex3 = x3 * x3'
mx3 = mean(x3)
X3 = 1/Ex3*fftshift(fft(x3));
f3 = (-1/2):1/N3:(1/2-1/N3);
EX3 = sum(abs(X3).^2);

%si le nombre de périodes est entier 
%on prends  4 périodes 
N5 =4*Tsin;
k5 = (0:N5-1);
x5 = sin(2*pi*k5/Tsin);
Ex5 = x5 * x5'
mx5 = mean(x5)
X5 = 1/Ex3*fftshift(fft(x5));
f5 = (-1/2):1/length(x5):(1/2-1/length(x5));
EX5 = sum(abs(X5).^2);

%sinus avec  zero padding

N4 =500;
k4 = (0:N4-1);
x4=zeros(1,N4);
x4(1:N3) = x3;
Ex4 = x4 * x4'
mx4 = mean(x4)
X4 = 1/Ex4*fftshift(fft(x4));
f4 = (-1/2):1/N4:(1/2-1/N4);
EX4 = sum(abs(X4).^2)







figure(1)

subplot(2,1,1)
stem(k1,x1,'.r')
title('Signal x1(n)')
grid

subplot(2,1,2)
stem(k2,x2,'.r')
title('Signal x1(n) avec zero padding')
grid

figure(2);
%subplot(2,1,1)
plot(f2,abs(X2),'.r',f1,abs(X1),'*b',fth,abs(Xth),'g')
title('fft(x1) (.r)  et fft(x2) (*b), normalisŽs en Žnergie pour  que ils  soyent superposŽs en amplitude')
xlabel('f/Fs [1] ')
legend('fft(x1)')
grid


figure(3)

subplot(3,1,1)
stem(k3,x3,'.r')
title('Signal x3(n)')
grid

subplot(3,1,2)
stem(k5,x5,'.r')
title('Signal x5(n) nombre entier  de périodes')
grid

subplot(3,1,3)
stem(k4,x4,'.r')
title('Signal x3(n) avec zero padding')
grid

figure(4);
subplot(3,1,1)
plot(f3,20*log10(abs(X3)),'*r')
title('|X3(f)| de un nombre  non entier  de périodes  echantillon')
xlabel('f/Fs [1] ')
ylabel('|X| [dB]')
legend('fft(x3)')
grid

subplot(3,1,3)
plot(f4,20*log10(abs(X4)),'.b')
title('|X4(f)| zero padding  apres les 4 périodes de sinus X4 = X3 * sinc')
xlabel('f/Fs [1] ')
ylabel('|X| [dB]')
legend('fft(x4) avec zeropad')
grid


subplot(3,1,2)
plot(f5,20*log10(abs(X5)),'*b')
title('|X5(f)| 4 périodes  exactes  moins  1 echantillon')
xlabel('f/Fs [1] ')
ylabel('|X| [dB]')
legend('fft(x5) Nb entier de périodes')
grid