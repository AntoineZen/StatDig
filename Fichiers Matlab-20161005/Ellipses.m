%% Ellipses centrees 
% M.Tognolini 2011  TstatDig


clc

clear all;
close all;

%% construction d'une ellipse avec l'equation paramétrique
N = 1000;
alpha = linspace(0,2*pi,N);

a = 10;
b = 5;
xc =0;
yc= 0;

xi = a*sin(alpha)+ xc;
yi = b*cos(alpha) + yc;

%ajout du bruit
Nx = 0.3;
Ny = 0.3;
nx = Nx*randn(1,N);
ny = Ny*randn(1,N);

xn = xi+nx;
yn = yi+ny;

%% Calcul par les moindres carrés  les  parametres de  léquation  générale
% l'équation géneral est :  ax^2 + by^2 + cx + dy   = 1
% les inconnues  sont les paramètres a,b,c,d
% La matrice  A = [xi^2, yi^2, xi, yi]  le  vescteur x = [a,b,c,d]'
% le  vecteur vb = [1,1,1,....]'
% La  solution aux  moindres carrée  est x0 = A\ vb

A = [xn'.^2 , yn'.^2 , xn', yn'];

vb = ones(N,1);

P = inv(A'*A) *A';
x0 = P * vb
x0 = A\vb


vbapp = A * x0;
e= (vb - vbapp);

test = vbapp'*e   %doit etre nul

eav = mean(e)
erms = sqrt(std(e)^2 + eav^2)

erms2 = sqrt(vb' * e)

a0 = 1/sqrt(x0(1))
b0 = 1/sqrt(x0(2))
xc0 = x0(3)/(-2*x0(1))
yc0 = x0(4)/(-2*x0(2))

% Plot  de l'ellipse  optimum

xopt = a0*sin(alpha) + xc0;
yopt = b0*cos(alpha) + yc0;



figure(1)
plot (xi,yi,'r',xn,yn,'.b', xopt,yopt,'.r')