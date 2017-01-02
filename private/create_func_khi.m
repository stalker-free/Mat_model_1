function khi = create_func_khi(const,gamma)
% CREATE_FUNC_KHI Creates khi(x,k).
%	KHI(x,k) = CREATE_FUNC_KHI(CONSTANTS)
%	Creates khi(x,k) limited function.
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
khi = @(x,k)khi_aux(const, gamma, x, k);
end

function khi_val = khi_aux(const, gamma, x, k)
% sample = ones(1, const.N);
%     khi_val = 1 + sum(arrayfun(@(x, n)gamma{n}(x) ./ (k - 1i .* ...
%         const.happa(n)), bsxfun(@times,sample,x), 1:const.N, ...
%         'UniformOutput', false));
khi_val = 1.0;
for n = 1:const.N
  khi_val = khi_val + gamma{n}(x) ./ (k - 1i .* const.happa(n));
end
%khi_val=1.0+gamma{1:const.N}(x) ./ (k - 1i .* const.happa(1:const.N));
end
