%% Ellipses inclinés
%M.Tognolini 2011 HEIG-VD
%TstatDig


clc

clear all;


%% construction d'une ellipse avec l'equation paramétrique
N = 1000;
alpha = linspace(0,2*pi,N);

a = 10;
b = 5;

beta = pi/10;    %rotation des  axes principaux

Rot = [cos(beta)  sin(beta);  sin(beta)  cos(beta)];


xi = a*sin(alpha);
yi = b*cos(alpha);

 R= Rot * [xi; yi];
 xi = R(1,:) ;
 yi = R(2,:) ;

%ajout du bruit
N0 = 0.3;


n = N0 * randn(2,N);

xn = xi+n(1,:);
yn = yi+n(2,:);

%% Calcul par les moindres carrés  les  parametres de  léquation  générale
% l'équation géneral est :  ax^2 + by^2 + cx + dy  + exy = 1
% les inconnues  sont les paramètres a,b,c,d,e
% La matrice  A = [xi^2, yi^2, xi, yi, xiyi]  le  vescteur x = [a,b,c,d,e]'
% le  vecteur vb = [1,1,1,....]'
% La  solution aux  moindres carrée  est x0 = A\ vb

A = [xn'.^2 , yn'.^2 , xn', yn', xn'.*yn'];

vb = ones(N,1);

%P = inv(A'*A) *A';
%x0 = P * vb
x0 = A \ vb

%calcul de l'ellipse  a partir  des paramètres x0
%pour chaque xn on calcule le yopt correspondants
% il faut resoudre by^2 + (d + ex)y + (ax^2 +cx -1) = 0
% on renomme V = (d + ex)  et W = (ax^2 +cx -1) et Z = b
% Zy^2 + Vy + W = 0    y = (-V +- sqrt(V^2 -4ZW))/2Z

Z = ones(N,1)*x0(2);
V = ones(N,1)*x0(4) + x0(5)*xn';
W = x0(1) * xn'.^2 + x0(3)*xn' - ones(N,1);

Delta = V.^2 - 4.*Z.*W;
Ix = find(Delta > 0);  %pour  eviter  les valeur  complexes 

yoptp = (-V + sqrt(Delta))./(2*Z);  %val pos 

yoptn = (-V - sqrt(Delta))./(2*Z);  %val neg


% Plot  de l'ellipse  optimum

figure(1)
plot (xn,yn,'.b', xn(Ix),yoptp(Ix),'.r',xn(Ix),yoptn(Ix),'.r',xi,yi,'k')
title('Approx ellipses: Points (b), Ellipse  opti (r), ellipse de  départ (k)')
xlabel('x')
ylabel ('y')
grid;