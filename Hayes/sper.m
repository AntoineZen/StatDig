function [Px, r] = sper (x, win, M, n1, n2, NFFT)
%SPER	Spectrum estimation using periodogram smoothing.
% Same as per_smooth but uses covariance instead of correlation
%USAGE	Px = sper(x,win,M,n1,n2)
%
%	The spectrum of a process x is estimated using periodogram
%	smoothing.
%
%	x   : input sequence
%       n1  : starting index, x(n1)
%	n2  : ending index, x(n2)
%	win : The window type
%       1 = Rectangular
%		2 = Hamming
%		3 = Hanning
%		4 = Bartlett
%		5 = Blackman
%	M   :  Length of the window
%
%       If n1 and n2 are not specified the periodogram of the entire
%       sequence is computed.
%
%	The smoothed periodogram is returned in Px using a linear scale.
%
%  see also BART, MPER, PER, and WELCH
%
%---------------------------------------------------------------
% copyright 1996, by M.H. Hayes.  For use with the book
% "Statistical Digital Signal Processing and Modeling"
% (John Wiley & Sons, 1996).
%---------------------------------------------------------------
x = x(:);
% if nargin == 3
%     n1 = 1;
%     n2 = length(x);
% end;
R  = covarH (x (n1 : n2), M + 1);
r  = [conj(fliplr(R(1,2:M+1))),R(1,1),R(1,2:M+1)];
% r = xcorr (x, M, 'unbiased')';
M  = 2*(M+1)-1;
w  = ones(M,1);
if (win == 2)
    w = hamming(M);
elseif (win == 3)
    w = hanning(M);
elseif (win == 4)
    w = bartlett(M);
elseif (win == 5)
    w = blackman(M);
end;
rw = r'.*w;
Px = abs (fft (rw, NFFT));
Px(1) = Px(2);
end