function x = MakeComplexExponential(SigmaNoise, A, omega, Phi, N)
% This function makes an Complex exponential signal in white noise
% SigmaNoise is the standard deviation of the inpput signal
% omega is the vector of pulsations
% N is the length of the output signal x

%% Parameter
x = zeros (1, N);
n = 0 : N-1;
for iter = 1 : numel (A)
    x = x + A(iter) * exp (1i*(n*omega(iter)+Phi(iter)));
end
x = x + SigmaNoise * randn (1, N);
