function [w, E] = WienerFIR (x, d, p)
% Computes the weights of the Wiener FIR based on the known correlations
% 
% rxx, p by 1, autocorrelation of x[n]
% rdx, p by 1, intercorrelation between d[n] and x[n]
% Wd, Energy of d[n]
% FIROrder = p-1, p = number of taps of the FIR

if numel (x) ~= numel (d)
    error ('Dimensions of x and d must be the same');
end;

%% rxx
rxx = xcorr (x, p, 'biased'); rxx = rxx (p+1 : end);
rdx = xcorr (d, x, p, 'biased'); rdx = rdx (p+1 : end);
rdd0 = dot (d, d) / numel(d);

rdx = rdx (:);
Rxx = toeplitz (rxx, rxx');
w = Rxx \ rdx; % inv (Rxx) * rdx;

E = rdd0 - rdx' * w(:);
end

