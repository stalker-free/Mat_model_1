function x_i = find_F_zero(t_interval, F_func)
% FIND_F_ZERO Finds x(t) zeros.
%	(x_i(t)) = FIND_F_ZERO(T_INTERVAL, F)
%   Finds x(t) zeros from expression F(t,x_i(t)) = 0.
%   _i lies in [1, quantity_of_x_zeros].
%
%	See also CREATE_FUNCTIONAL_T, CREATE_FUNC_F.
s = length(t_interval);
opts = optimoptions('fsolve', 'Display', 'off' ...
    , 'DiffMinChange', 1e-4);
x_i = zeros(1,s);
for i=1:s
    x_i(i) = fsolve(@(x)F_func(t_interval(i), x), 0.0, opts);
end