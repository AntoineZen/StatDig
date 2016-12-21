%% Exemple431.m
% The signal is model generated, hence no modelisation error
% 1 model, the right one

%% Init
clear
close all

%% Parameters
b0 = 2;
a1 = .8;
N = 32;

%% Data
Num = b0;
Den = [1, a1];
printsys (Num, Den, 'z');
d = zeros (N, 1); d (1) = 1;
x = filter (Num, Den, d);

%% All pole model
p = 1;
q = 0;

[DenHat, NumHat] = pade (x, p, q);
printsys (NumHat', DenHat', 'z')
xHat = filter (NumHat, DenHat, d);

%% Display
figure
subplot (2, 2, 1)
stem (x), axis tight, xlabel ('n'), title ('x[n]')
subplot (2, 2, 2)
zplane (Num, Den), title ('Original')
subplot (2, 2, 3)
stem (xHat), axis tight, xlabel ('n'), title ('xHat[n]')
subplot (2, 2, 4)
zplane (NumHat', DenHat'), title ('Estimated')

%% Print 2 file
print ('-f1', '-dpng', 'Exemple431.png')