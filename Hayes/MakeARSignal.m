function [ x ] = MakeARSignal(SigmaNoise, a, N)
% This function makes an AR signal
% SigmaNoise is the standard deviation of the inpput signal
% a is the vector of AR coeffficients, the ith element, a(i) is the coefficient of x(k-i)
% N is the length of the output signal x

%% Parameter
N1 = min (2000, 10*N);

a = a(:)';
noise = SigmaNoise * randn (N1,1);  % Normalized white Gaussian noise
x = filter (1, [1, a], noise);
x = x (N1 - N + 1 : N1); % To avoid transcient problems

end