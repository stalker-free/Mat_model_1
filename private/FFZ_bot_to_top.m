function [x_i, exitflag] = FFZ_bot_to_top(t_interval, F_func, param)
% FFZ_BOT_TO_TOP Finds x(t) zeros.
%	[X_I, EXITFLAG] = FFZ_BOT_TO_TOP(T_INTERVAL, F_FUNC, PARAM)
%   Finds x(t) zeros from expression F(t,x_i(t)) = 0.
%   _i lies in [1, quantity_of_x_zeros].
%
%	See also CREATE_FUNCTIONAL_T, CREATE_FUNC_F.

init = (param.asymptote{param.idx}(t_interval(1)) + ...
     param.asymptote{param.idx + 1}(t_interval(1)) ) ./ 2.0;

[a, b] = getNearest(param.asymptote, init, t_interval(1));

if param.tol < 1.0
    softtol = sqrt(param.tol);
else
    softtol = power(param.tol, 1.5);
end

s = length(t_interval);
opts = optimset('Display', 'none', 'TolFun', param.tol, ...
    'TolX', param.tol, 'DiffMaxChange', param.tol);
x_i = zeros(1,s);
exitflag = zeros(1,s);
noise = init .* softtol .* length(param.asymptote);

[x_i(1), ~, ~, exitflag(1)] = lsqnonlin( ...
    @(x)F_func(t_interval(1), x), init, a, b, opts);

for k=2:s

[a, b] = getNearest(param.asymptote, x_i(k - 1), t_interval(k));
[x_i(k), ~, ~, exitflag(k)] = lsqnonlin(@(x)F_func(t_interval(k), x), ...
    x_i(k - 1) + t_interval(k) .* noise, a, b, opts);

end % for i=1:threshhold

end