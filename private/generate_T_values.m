function F_f = generate_T_values(F_func, t_interval, x_interval)
%GENERATE_T_VALUES Generate matrix of T determinant.
%   GENERATE_T_VALUES(F_FUNC, T_INTERVAL, X_INTERVAL)
%   See also CREATE_FUNCTIONAL_T.
F_f = zeros(length(t_interval));
for p = 1:length(F_f)
    F_f(p,:) = F_func(t_interval(p), x_interval);
end
end

