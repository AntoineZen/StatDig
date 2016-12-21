function [a, sigma] = phd (x, p)
%PHD	Frequency estimation using the Pisarenko harmonic decomposition.
%---
%USAGE	[a,sigma] = phd(x,p)
% a = Vmin, the eigenvector corresponding to the smallest eigenvalue
% sigma = VarNoise, the estimate of the noise variance
%
%	The input sequence x is assumed to consist of p complex
%	exponentials in white noise.  The frequencies of the
%	complex exponentials and the variance of the white noise
%	are estimated using the Pisarenko harmonic decomposition.
%
%	The frequency estimates are found from the peaks of the
%	pseudospectrum
%			         1
%		-----------------------------------
%		1 + a(1)exp(jw) + ... + a(p)exp(jpw)
%
%	or from the roots of the polynomial formed from the
%	vector a.  The estimate of the white noise variance is
%	returned in sigma.
%
%  see also MUSIC, EV, and MIN_NORM
%
%---------------------------------------------------------------
% copyright 1996, by M.H. Hayes.  For use with the book
% "Statistical Digital Signal Processing and Modeling"
% (John Wiley & Sons, 1996).
%---------------------------------------------------------------

x = x (:);
R = covarH (x, p + 1);
[v, d] = eig (R);
sigma = min (diag (d));
% index = find (diag (d) == sigma);
% a = v (:, index);
index = (diag (d) == sigma);
a = v (:, index);
end