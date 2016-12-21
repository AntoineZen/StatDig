function x = MakeMASignal(SigmaNoise, b, N)
% This function makes an AR signal
% SigmaNoise is the standard deviation of the inpput signal
% a is the vector of AR coeffficients, the ith element, a(i) is the coefficient of x(k-i)
% N is the length of the output signal x

%% Parameter
N1 = min (1000, 10*N);

b = b(:)';
a = zeros (size (b));
a(1) = 1;
noise = SigmaNoise * randn (N1,1);  % Normalized white Gaussian noise
x = filter (b, a, noise);
x = x (N1 - N + 1 : N1); % To avoid transcient problems

end

