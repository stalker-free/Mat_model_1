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
%	See also CREATE_FUNC_DA, SYM, SOLVE, MATLABFUNCTION, class CONST.
B = @(n, x_m)(const.b(n) .* ...
    exp(-2.0 .* const.happa(n) .* x_m) ./ ...
    da_func(1i .* const.happa(n)));
A = eye(const.N, const.N);

C = @(A_matr, n, x_m)(A_matr - ...
    sum(1i .* B(n, x_m) ./ (const.happa(n) + const.happa)));

% m_s = max(size(x_interval));
% gamma = zeros(const.N, m_s);
% for j = 1:const.N
%     for k = 1:m_s
%         gamma(j, k) = 
%     end
% end

gamma_aux = B(1:const.N, x_interval) / C(A, 1:const.N, x_interval);
figure
plot(x_interval, imag(gamma_aux), '-')%, ...
   % real(gamma_aux), imag(gamma_aux), 'ro')

% gamma_poly = cell(1,const.N);
% for k = 1:const.N
%     gamma_poly{k} = polyfit(x_interval,gamma_aux(k,:),5);
% end
% for k = 1:const.N
%     gamma_val{k} = containers.Map('KeyType', 'double', 'ValueType', 'any');
%     for l = 1:m_s
%         gamma_val{k}(x_interval(l)) = gamma_aux(k,l);
%     end
% end
% function val = g_f(x)
%     val = zeros(1,const.N);
%     for p = 1:const.N
%         val(p) = gamma_val{p}(x);
%     end
% end
    function val = gamma_f(g_v, x)
        find_line_value = @(x0,x1,x2)(x1+x2*abs((x0-x1)/(x2-x1)));
        tol = 1e-6;
        real_s = ismembertol(real(g_v), real(x), tol);
        imag_s = ismembertol(imag(g_v), imag(x), tol);
        % Check if g_v already has x
        %if(real_s(real_s ~= 0) && imag_s(imag_s ~= 0))
        if(intersection(real_s, imag_s))
            val = x;
        % Generate value from line segment
        else
            lesser = find(g_v <= x, 1, 'last');
            bigger = find(g_v > x);
            val = find_line_value(real([x,lesser,bigger])) + ...
                1i * find_line_value(imag([x,lesser,bigger]));
        end
    end

gamma = cell(1,const.N);
for k = 1:const.N
    gamma{k} = @(x)gamma_f(gamma_aux(k),x);
end
end
%     function s_f = gen_s(n)
%         function s_val = s_aux(x)
%             s_val = 0;
%             for m=1:const.N
%                 s_val = s_val + sym_G{m}(x)./(const.happa(n)+const.happa(m));
%             end
%             s_val = sum(sym_G(x)./(const.happa(n)+const.happa));
%             s_val = 1i .* s_val + 1;
%         end
%     s_f = @s_aux;
%     end
% S = gen_s(const.N);
% sym_G = solve(sym_G == ...
%     (const.b.*exp(-2.0.*const.happa.*sym_x).*S(sym_x))./ ...
%     da_func(1i .* const.happa));
% 
% gamma = matlabFunction(sym_G);
% end