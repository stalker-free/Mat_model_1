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