function [f_plus, f_minus] = determinate_T(func_t)
% DETERMINATE_T Get determinate of T(t, x).
%	det(T) = DETERMINATE_T(FUNC_T, T, X)
%
%                | t11(x + t)	t12(x + t) |
% det(T(t, x)) = |                         |
%                | t21(x - t)	t22(x - t) |
%
%	See also CREATE_FUNCTIONAL_T.
% det = func_t{1, 1}(x + t) .* func_t{2, 2}(x - t) - ...
%     func_t{1, 2}(x + t) .* func_t{2, 1}(x - t);
f_plus = @(t, x)(func_t{1, 1}(x + t) ./ func_t{1, 2}(x + t));
f_minus = @(t, x)(func_t{2, 1}(x - t) ./ func_t{2, 2}(x - t));
end