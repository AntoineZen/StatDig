function [Px, r] = per_smooth (x, win, M, n1, n2, NFFT)
%SPER                                              [mhh3 5/94]
% Same as per_smooth but uses correlation instead of covariance
%       Px = per_smooth(x,n1,n2) computes the smoothed periodogram
%       of x(n) beginning with x(n1) and ending with x(n2).
%       If n1 and n2 are not specified the periodogram of the
%	entire sequence will be computed.
%	The window type is specified by win
%       1 = rectangular
%		2 = Hamming
%		3 = Hanning
%		4 = Bartlett
%		5 = Blackman
%	and the length in M.

x   = x(:);

%% Correlation estimate
r = xcorr (x, M) / (numel(x));
M  = 2*(M+1)-1;

%% Window selection
w  = ones (M, 1);
if (win == 2)
    w = hamming (M);
elseif (win == 3)
    w = hanning (M);
elseif (win == 4)
    w = bartlett (M);
elseif (win == 5)
    w = blackman (M);
end;

%% Windowing of the correlation
rw = r.*w;

%% BT estimator
Px = abs (fft (rw, NFFT));
Px(1) = Px(2); % ??