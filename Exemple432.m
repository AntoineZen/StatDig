%% Exemple432.m
% The number of degrees of freedom is constant p + q = 2
% 3 models AR, MA, ARMA

%% Init
clear
close all

%% Data
x = [1, 1.5, 0.75, 0.375, 0.1875, 0.0938]';
N = numel (x);
d = zeros (size (x)); d (1) = 1;

%% All pole model
p = 2;
q = 0;

[a.AR, b.AR] = pade (x, p, q);
printsys (b.AR', a.AR', 'z')
xhat.AR = filter (b.AR, a.AR, d);

%% All zero model
p = 0;
q = 2;

[a.MA, b.MA] = pade (x, p, q);
printsys (b.MA', [1, 0, 0], 'z')
xhat.MA = filter (b.MA, a.MA, d);

%% Pole and Zero model
p = 1;
q = 1;

[a.ARMA, b.ARMA] = pade (x, p, q);
printsys (b.ARMA', a.ARMA', 'z')
xhat.ARMA = filter (b.ARMA, a.ARMA, d);

%% Display
figure
Min = min (min ([x, xhat.AR, xhat.MA, xhat.ARMA]));
Max = max (max ([x, xhat.AR, xhat.MA, xhat.ARMA]));
MinE = min (min ([x-xhat.AR, x-xhat.MA, x-xhat.ARMA]));
MaxE = max (max ([x-xhat.AR, x-xhat.MA, x-xhat.ARMA]));

subplot (3, 2, 1)
bar ([x, xhat.AR]), axis ([1, N, Min, Max]), title ('AR model, x, x_{est}')
subplot (3, 2, 2)
bar (x - xhat.AR), axis ([1, N, MinE, MaxE]), title ('AR model, e')
subplot (3, 2, 3)
bar ([x, xhat.MA]), axis ([1, N, Min, Max]), title ('MA model, x, x_{est}')
subplot (3, 2, 4)
bar (x - xhat.MA), axis ([1, N, MinE, MaxE]), title ('MA model, e')
subplot (3, 2, 5)
bar ([x, xhat.ARMA]), axis ([1, N, Min, Max]), title ('ARMA model, x, x_{est}')
subplot (3, 2, 6)
bar (x - xhat.ARMA), axis ([1, N, MinE, MaxE]), title ('ARMA model, e')

%% Print 2 file
print ('-f1', '-dpng', 'Exemple432.png')

%% LaTeX
latex (sym(x'))