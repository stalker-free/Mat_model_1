function [x_i, exitflag] = FFZ_w_o_line_interp(t_interval, F_func, param)
% FIND_F_ZERO Finds x(t) zeros.
%	(x_i(t)) = FIND_F_ZERO(T_INTERVAL, F)
%   Finds x(t) zeros from expression F(t,x_i(t)) = 0.
%   _i lies in [1, quantity_of_x_zeros].
%
%	See also CREATE_FUNCTIONAL_T, CREATE_FUNC_F.

cnt = param.center;

init = (param.asymptote{param.idx}(t_interval(cnt)) + ...
     param.asymptote{param.idx + 1}(t_interval(cnt)) ) ./ 2.0;

[a_init, b_init] = getNearest(param.asymptote, init, t_interval(cnt));

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

[x_i(cnt), ~, ~, exitflag(cnt)] = lsqnonlin( ...
    @(x)F_func(t_interval(cnt), x), init, a_init, b_init, opts);
[x_i(cnt + 1), ~, ~, exitflag(cnt + 1)] = ...
    lsqnonlin(@(x)F_func(t_interval(cnt + 1), x), ...
    x_i(cnt) + t_interval(cnt + 1) .* noise, a_init, b_init, opts);
[x_i(cnt - 1), ~, ~, exitflag(cnt - 1)] = ...
    lsqnonlin(@(x)F_func(t_interval(cnt - 1), x), ...
    x_i(cnt) + t_interval(cnt - 1) .* noise, a_init, b_init, opts);
threshhold = s - cnt;

for i=2:threshhold

% Bottom half
k = cnt - i;
[a, b] = getNearest(param.asymptote, x_i(k + 1), t_interval(k));
[x_i(k), ~, ~, exitflag(k)] = lsqnonlin(@(x)F_func(t_interval(k), x), ...
    x_i(k + 1) + t_interval(k) .* noise, a, b, opts);

if(abs(x_i(k) - x_i(k + 1)) > softtol)
[a, b] = getNearest(param.asymptote, x_i(k + 2), t_interval(k + 1));
x_i(k) = lsqnonlin(@(x)F_func(t_interval(k), x), ...
    x_i(k + 1) + t_interval(k) .* noise, a, b, opts);
exitflag(k) = 4;

    if(abs(x_i(k) - x_i(k + 1)) > softtol)
    x_i(k) = lsqnonlin(@(x)F_func(t_interval(k), x), ...
     x_i(k + 1) - t_interval(k) .* noise, a - softtol, b + softtol, opts);
    exitflag(k) = 5;

    end

end

% Top half
k = cnt + i;
[a, b] = getNearest(param.asymptote, x_i(k - 1), t_interval(k));
[x_i(k), ~, ~, exitflag(k)] = lsqnonlin(@(x)F_func(t_interval(k), x), ...
    x_i(k - 1) + t_interval(k) .* noise, a, b, opts);

if(abs(x_i(k) - x_i(k - 1)) > softtol)
[a, b] = getNearest(param.asymptote, x_i(k - 2), t_interval(k - 1));
x_i(k) = lsqnonlin(@(x)F_func(t_interval(k), x), ...
    x_i(k - 1) + t_interval(k) .* noise, a, b, opts);
exitflag(k) = 4;

    if(abs(x_i(k) - x_i(k - 1)) > softtol)
    x_i(k) = lsqnonlin(@(x)F_func(t_interval(k), x), ...
     x_i(k - 1) - t_interval(k) .* noise, a - softtol, b + softtol, opts);
    exitflag(k) = 5;

    end

end

end % for i=1:threshhold

end