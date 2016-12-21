function [w, E] = WienerFIRCorr (rxx, rdx, Wd)
% Computes the weights of the Wiener FIR based on the known correlations
% 
% rxx, p by 1, autocorrelation of x[n]
% rdx, p by 1, intercorrelation between d[n] and x[n]
% Wd, Energy of d[n]
% FIROrder = p-1, p = number of taps of the FIR

if numel (rxx) ~= numel (rdx)
    error ('Dimensions of rxx and rdx must be the same');
end;

rxx = rxx (:);
rdx = rdx (:);
Rxx = toeplitz (rxx, rxx');
w = Rxx \ rdx; % inv (Rxx) * rdx;

E = Wd - rdx' * w(:);
end

