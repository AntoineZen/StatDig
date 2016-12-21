function [A, E] = lmsPVector (x, d, mu, nord, a0, rdx)
%LMS	Adaptive filtering using P-vector LMS algorithm, proposed by
%Griffiths.

%---
%USAGE [A,E] = lms(x,d,mu,nord,a0, rdx)
%
%           x    : input data to the adaptive filter.
%           d    : desired output
%           mu   : adaptive filtering update (step-size) parameter
%           nord : number of filter coefficients
%           a0   : (optional) initial guess for FIR filter
%		   coefficients - a row vector.  If a0 is omitted
%		   then a0=0 is assumed.
%          rdx   : cross-correlation with nord lags between d and x
%     The output matrix A contains filter coefficients.
%        - The n'th row contains the filter coefficients at time n
%        - The m'th column contains the m'th filter coeff vs. time.
%        - The output vector E contains the error sequence versus time.
%
%  see also NLMS and RLS
%
%---------------------------------------------------------------
% copyright 1996, by M.H. Hayes.  For use with the book
% "Statistical Digital Signal Processing and Modeling"
% (John Wiley & Sons, 1996).
%---------------------------------------------------------------
% Does not work yet

rdx = rdx (:);

X = convm (x, nord);
[M, N] = size(X);
a0   = a0(:).';
% E(1) = d(1) - a0 * X (1, :).';
A = zeros (M, nord);
A (1,:) = a0 + mu * transpose(rdx) - mu * (A(1, :) * transpose (X (1, :))) * conj (X (1, :));
if M > 1
    for k = 2 : M - nord + 1
        E (k) = d (k) - A (k - 1, :) * X (k, :).';
        A (k, :) = A (k - 1, :) + mu * transpose (rdx) - mu * (A(k, :) * transpose (X (k, :))) * conj (X (k, :));
    end;
end;