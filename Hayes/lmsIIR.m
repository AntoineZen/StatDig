function [A, B, e] = lmsIIR (x, d, Mu, p, q)
%LMSIIR	Recursive Adaptive filtering using Table 9.5 of the Hayes book.
%---
%USAGE [A,B, E] = lmsIIR (x, d, mu, p, q)
%
%           x    : input data to the adaptive filter.
%           d    : desired output
%           mu   : adaptive filtering update (step-size) parameter
%           p    : number of recursive filter coefficients
%           q    : number of non-recursive filter coefficients
%
%     The output matrices A and B contains recursive and non-recursive filter coefficients.
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

N = numel (x); % Number of samples of x and d
yf = zeros (N, 1);
xf = zeros (N, 1);
y = zeros (N, 1);
e = zeros (N, 1);
A = zeros (N, p); % The p recursive coefficients
B = zeros (N, q); % The q non-recursive coefficients

for n = max(p, q - 1) + 1 : N - 1
    for k = 1 : p
        y(n) = y(n) + A (n, k) * y (n - k);
    end;
    
    for k = 1 : q
        y (n) = y (n) + B (n, k) * x (n - k + 1);
    end;
    
    e(n) = d(n) - y(n);
    
    Add = 0;
    for k = 1 : p
        if n > p
            Add = Add + conj (A (n, k)) * yf (n - k);
        end;
    end;
    yf (n) = y (n) + Add;
    
    Add = 0;
    for k = 1 : p
        if n > p
            Add = Add + conj (A (n, k)) * xf (n - k);
        end;
    end;
    xf (n) = x (n) + Add;
    
    for k = 1 : p
        if n > p
            A (n + 1, k) = A (n, k) + Mu * e (n) * yf (n - k);
        end;
    end;
    for k = 1 : q
        if n > q
            B (n + 1, k) = B (n, k) + Mu * e(n) * xf (n - k);
        end;
    end;
end;

% a0   = a0(:).';
% b0   = b0(:).';

% q = numel (b0)-1; % From 0 to q
% p = numel (a0);
% N = numel (x);
% B = zeros (N, q+1);
% B (1, :) = b0;
% A = zeros (N, p);
% A (1, :) = a0;
%
% X = convm (x, q+1);
% Y = zeros (N+p, p);
% y = zeros (N, 1);
% e = zeros (N, 1);

% PsiA = zeros (N, p);
% PsiB = zeros (N, q+1);
%
% for n = 2 : N
%     y(n) = Y (n-1, :)*transpose(A(n, :))+X(n, :)*transpose(B(n, :));
%     e(n) = d(n) - y(n);
%
%     for k = 1 : p
%         if n > p
%             % PsiA (n, k) = conj (y(n-k)) + A (n, :) * transpose (PsiA (n-1:n-p, k));
%             PsiA (n, k) = conj (y(n)) + A (n, :) * transpose (PsiA (n-1:n-p, k));
%             A (n+1, k) = A (n, k) + Mu * e(n) * PsiA (n, k);
%         end;
%     end;
%
%     for k = 0 : q
%         if n > q
%             % PsiB (n, k+1) = conj (x(n-k)) + A (n, :) * transpose (PsiB (n-1:n-p, k+1));
%             PsiB (n, k+1) = conj (x(n)) + A (n, :) * transpose (PsiB (n-1:n-p, k+1));
%             B (n+1, k+1) = B (n, k+1) + Mu * e(n) * PsiB (n, k+1);
%         end;
%     end;
% end;