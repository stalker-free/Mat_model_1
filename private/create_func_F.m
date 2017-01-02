function F_func = create_func_F(funcs_t)
% CREATE_FUNC_F Creates F(t,x).
%	F(t,x) = CREATE_FUNC_F(T)	Creates F(t,x) function for further use.
%
%	See also CREATE_FUNCTIONAL_T.
F_func = @(t,x)F_aux(funcs_t,t,x);
end

function F_val = F_aux(f_t,t,x)
    F_val = f_t{1,1}(x + t) .* f_t{2,2}(x - t) - ...
        f_t{1,2}(x + t) .* f_t{2,1}(x - t);
end