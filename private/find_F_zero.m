function x_i = find_F_zero(t_interval, F_func, init_point)
% FIND_F_ZERO Finds x(t) zeros.
%	(x_i(t)) = FIND_F_ZERO(T_INTERVAL, F)
%   Finds x(t) zeros from expression F(t,x_i(t)) = 0.
%   _i lies in [1, quantity_of_x_zeros].
%
%	See also CREATE_FUNCTIONAL_T, CREATE_FUNC_F.
s = length(t_interval);
opts = optimoptions('fsolve', 'Display', 'none', ...
    'Algorithm', 'levenberg-marquardt');
x_i = zeros(1,s);
% x_i = arrayfun(@(t)fsolve(@(x)F_func(t, x), init_point, opts), t_interval);
x_i(1) = fsolve(@(x)F_func(t_interval(1), x), init_point, opts);
threshhold = init_point .* 1e-3;
for i=2:s
%     if(mod(t_interval(i), 1.25) <= 1e-12)
%         x_i(i) = fsolve(@(x)F_func(t_interval(i), x), init_point, opts);
%     else
    x_i(i) = fsolve(@(x)F_func(t_interval(i), x), x_i(i-1) + ...
        t_interval(i) .* threshhold, opts);
%     end
end

% i_ = 1;
% while(i_ <= s)
% x_i(1+100.*(i_-1)) = fsolve(@(x)F_func(t_interval(1+100.*(i_-1)), x), ...
%     init_point, opts);
% for j_ = 2 + 100 * (i_ - 1):100 * i_
%     x_i(j_) = fsolve(@(x)F_func(t_interval(j_), x), x_i(j_-1), opts);
% end
% end