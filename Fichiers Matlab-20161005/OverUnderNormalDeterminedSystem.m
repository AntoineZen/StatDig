% OverUnderNormalDeterminedSystem.m
% (c) M.Kocher  HEIG-VD
% modified: M.Tognolini HEIG-VD 2011

%% Init
clear

%% Parameters
N = 5; % Signal length

%% Data
% Phi = rand (N, N);
k = 1 : N
Phi = vander (1:N)   % Square matrix, full rank 
Theta = rand (N, 1)  % random  coeff.
Y = Phi*Theta        % Reference  signal

%% Normal
Theta1 = (Phi'*Phi)^(-1)*Phi'*Y   % calculated coeff exact solution
Ya1 = Phi*Theta1                  % calculated signal Y exact solution

%% Overdetermined system
Phi2 = fliplr (Phi (:, end-1:end)); % Rectangular matrix more eq than unknowns
Theta2 = (Phi2'*Phi2)^(-1)*Phi2'*Y; % least mean square  coeffs
Ya2 = Phi2*Theta2;                  % last mean square  solution

%% Underdetermined system less eq. than unknowns
Phi3 = Phi((1:N-3),:)
Y3 = Y(1:N-3)
Theta3 = Phi3'*(Phi3*Phi3')^(-1)*Y3
Ya3 = Phi * Theta3




%% Display
subplot (3, 3, 1)
plot (k, Y, 'or', k, Ya1, '*g'), title (['Normal, Y(r), Y_{a1}(g), rank(\Phi) = ', num2str(rank(Phi))]), axis tight
subplot (3, 3, 2)
plot (k, Theta, 'or', k, Theta1, '*g'), title ('Coeff: \Theta, \Theta_1'), axis tight
subplot (3, 3, 3)
plot (Phi), title ('Base functions \Phi')

subplot (3, 3, 4)
plot (k, Y, 'or', k, Ya2, '*g'), title (['Overdetermined (5eq) ), Y(r), Y_{a2}(g), rank(\Phi) = ', num2str(rank(Phi2))]), axis tight
subplot (3, 3, 5)
plot (k, Theta, 'or', 1:length(Theta2), Theta2, '*g'), title ('Coeff: \Theta, \Theta_2'), axis tight
subplot (3, 3, 6)
plot (Phi2), title ('Base Functionsv \Phi_2')

subplot (3, 3, 7)
plot (k, Y, 'or', k, Ya3, '*g'), title (['Underdetermined (2eq), Y(r), Y_{a3}(g), rank(\Phi) = ', num2str(rank(Phi3))]), axis tight
subplot (3, 3, 8)
plot (k, Theta, 'or', 1:length(Theta3), Theta3, '*g'), title ('Coeff: \Theta, \Theta_3'), axis tight
subplot (3, 3, 9)
plot (Phi3), title ('Base Functionsv \Phi_3')

