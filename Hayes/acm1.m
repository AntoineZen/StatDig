function [a,err] = acm1 (rxx)
% Same as acm but permits the modification of rxx before computing the
% Yule-Walker equations, for exercice C83

%% Check
rxx = rxx (:); % Should be vertical

%% Toeplitz matrix, should be Hermitian
Rxx = toeplitz (rxx(1:end-1), rxx(1:end-1)'); % Should be Hermitian
rxx1 = (rxx (2:end));

%% a computation
a = -inv (Rxx) * rxx1(:);
a = [1; a];

%% Sum of square prediction errors, should be real
err = rxx' * a;