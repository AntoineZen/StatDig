%% Exemple441.m

%% Init
clear
close all

%% Data
N = 41;
N1 = 21;
x = zeros (N, 1);
x (1:N1) = 1;

d = zeros (size (x)); d (1) = 1;

%% Pole and Zero Prony model
p = 1;
q = 1;

[a.Prony, b.Prony, err] = prony (x, p, q);

printsys (b.Prony', a.Prony', 'z')
xhat.Prony = filter (b.Prony, a.Prony, d);
e.Prony = conv (x, a.Prony');
for iter = 1 : numel (b.Prony)
    e.Prony (iter) = e.Prony(iter)-b.Prony (iter);
end;

Epsilon.Prony = norm (e.Prony);

%% Pole and Zero Pade model
p = 1;
q = 1;

[a.Pade, b.Pade] = pade (x, p, q);

printsys (b.Pade', a.Pade', 'z')
xhat.Pade = filter (b.Pade, a.Pade, d);
e.Pade = conv (x, a.Pade');
for iter = 1 : numel (b.Pade)
    e.Pade (iter) = e.Pade(iter)-b.Pade (iter);
end;
Epsilon.Pade = norm (e.Pade);

%% Display
figure
Min = min (min ([x, xhat.Prony, xhat.Pade]));
Max = max (max ([x, xhat.Prony, xhat.Pade]));
MinE = min (min ([x-xhat.Prony, x-xhat.Pade]));
MaxE = max (max ([x-xhat.Prony, x-xhat.Pade]));

subplot (4, 1, 1)
bar ([x, xhat.Prony]), axis ([1, N, Min, Max]), title ('Prony ARMA model, x, x_{est}')
subplot (4, 1, 2)
bar (e.Prony), axis ([1, N, MinE, MaxE]), title (['Prony ARMA model, e, \epsilon = ', num2str(Epsilon.Prony)])
subplot (4, 1, 3)
bar ([x, xhat.Pade]), axis ([1, N, Min, Max]), title ('Pade ARMA model, x, x_{est}')
subplot (4, 1, 4)
bar (e.Pade), axis ([1, N, MinE, MaxE]), title (['Pade ARMA model, e, \epsilon = ', num2str(Epsilon.Pade)])

%% Print 2 file
print ('-f1', '-dpng', 'Exemple441.png')

%% LaTeX
latex (sym(x'))