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
function B_val = B_aux(n, x_m)
    b = const.b(n);
    e = exp(-2.0 * const.happa(n)' * x_m);
    B_val = zeros(size(e));
    da = da_func(1i * const.happa(n));
    for k=n
        B_val(k,:) = b(k) .* e(k,:) ./ da(k);
    end
end
B = @B_aux;
A = eye(const.N, const.N);

function C_val = C_aux(A_matr, n, x_m)
    sz = size(x_interval,2);
    C_val = zeros(const.N, const.N, sz);
    sub = 1i .* B(n, x_m) ./ sum(const.happa(n) + const.happa);
    for k_=n
        for l=n
            for mn=1:sz
                C_val(k_,l,mn) = A_matr(k_,l) - sub(k_,mn);
            end
        end
    end
end
C = @(A_matr, n, x_m)(A_matr - ...
    1i .* B(n, x_m) ./ sum(const.happa(n) + const.happa));

% Get values from solution function...
gamma_aux = B(1:const.N, x_interval) ./ C(A, 1:const.N, x_interval);
figure
plot(x_interval, imag(gamma_aux), '-')

% ...and present them as "continuous function"
gamma = cell(1, const.N);
for g = 1:const.N
    gamma{g} = @(x)spline(x_interval, gamma_aux(g,:), x);
end
end