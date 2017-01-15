function khi_val = khi(const, gamma, x, k)
% KHI Wave function.
%	KHI = KHI(CONSTANTS, GAMMA, X, K)
%	Calculate wave limited function khi.
%
%	Constants are:
%	N+, N- -- quantities of number sets. Must be positive integers.
%
%	Happa+, Happa- -- eigenvalues. Must be positive.
%
%	b+, b- -- factor before reversed exponent.
%	Elements with odd index must be positive, even -- negative.
%
%	See also CREATE_FUNC_GAMMA, class CONST.
khi_val = 1.0;
for n = 1:const.N
  khi_val = khi_val + gamma{n}(x) ./ (k - 1i .* const.happa(n));
end
end
