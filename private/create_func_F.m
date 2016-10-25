function F_func = create_func_F(funcs_t)
% CREATE_FUNC_F Creates F(t,x).
%	F(t,x) = CREATE_FUNC_F(T)	Creates F(t,x) function for further use.
%
%	See also CREATE_FUNCTIONAL_T.
    function F_val = F_aux(t,x)
        F_val = funcs_t{1,1}(x + t) .* funcs_t{2,2}(x - t) - ...
            funcs_t{1,2}(x + t) .* funcs_t{2,1}(x - t);
    end
    F_func = @F_aux;
end
