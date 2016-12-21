% Exercice C4.1
clc
N = 20; % We are considering 20 sampels

n = 1:N; % Create the samples vector

nd = 5; % Let the filter delay be 10 (N/2) samples

wc = pi/2;

% Define the step response
h_n =  sin((n - nd) * wc) ./ ((n-nd) * 2*wc);
h_n(nd) = .5;

%plot(n, h_n);

% Padé aproximation paramters
p = 2;

q = 20-p-1;

% Do the padé aproximation to compute the a and b coef.
[a,b] = pade(h_n,p,q);
a = a'
b = b'

%printsys(a, b, 'z')
bode(a, b )

% Build a "delta" function
d = zeros(1,N); d(1) = 1;

% Filter the delta function with our padé build filter to test
y_hat = filter(b, a, d);

%plot(y_hat)
