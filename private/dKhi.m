function dKhi_val = dKhi(const, gamma, x, k)
% DKHI k-derivative of wave function.
%	DKHI = DKHI(CONSTANTS, GAMMA, X, K)
%	Calculate derivative of wave limited function khi by k.
%
%	Constants are:
%	N+, N- -- quantities of number sets. Must be positive integers.
%
%	Happa+, Happa- -- eigenvalues. Must be positive.
%
%	b+, b- -- factor before reversed exponent.
%	Elements with odd index must be positive, even -- negative.
%
%	See also CREATE_FUNC_GAMMA, KHI.
dKhi_val = 0.0;
for n = 1:const.N
  dKhi_val = dKhi_val - gamma{n}(x) ./ power(k - 1i .* const.happa(n),2.0);
end
end
