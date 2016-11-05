function gamma = create_func_gamma(const,da_func, x_interval)
% CREATE_FUNC_GAMMA Generates bundle of functions.
%   [GAMMA] = CREATE_FUNC_GAMMA(CONSTANTS,DA) Generates bundle of
%   functions through the solution of linear algebraic system.
%
%	Constants are:
%	N+, N- -- quantities of number sets. Must be positive integers.
%
%	Happa+, Happa- -- eigenvalues. Must be positive.
%
%	b+, b- -- factor before reversed exponent.
%	Elements with odd index must be positive, even -- negative.
%
%	See also CREATE_FUNC_DA, SPLINE, class CONST.

% Solve Cx = B algebraic equation
B = @(n, x_m)(const.b(n) .* ...
    exp(-2.0 .* const.happa(n) .* x_m) ./ ...
    da_func(1i .* const.happa(n)));
A = eye(const.N, const.N);

C = @(A_matr, n, x_m)(A_matr - ...
    1i .* B(n, x_m) ./ sum(const.happa(n) + const.happa));

% Get values from solution function...
gamma_aux = B(1:const.N, x_interval) ./ C(A, 1:const.N, x_interval);
% figure
% plot(x_interval, imag(gamma_aux), '-')

% ...and present them as "continuous function"
gamma = cell(1, const.N);
for k = 1:const.N
    gamma{k} = @(x)spline(x_interval, gamma_aux(k,:), x);
end