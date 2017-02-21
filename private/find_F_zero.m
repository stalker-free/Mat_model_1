function [x_i, exitflag] = find_F_zero(t_interval, F_func, param)
% FIND_F_ZERO Finds x(t) zeros.
%	(x_i(t)) = FIND_F_ZERO(T_INTERVAL, F)
%   Finds x(t) zeros from expression F(t,x_i(t)) = 0.
%   _i lies in [1, quantity_of_x_zeros].
%
%	See also CREATE_FUNCTIONAL_T, CREATE_FUNC_F.

cnt = param.center;

init = (param.asymptote{param.idx}(t_interval(cnt)) + ...
     param.asymptote{param.idx + 1}(t_interval(cnt)) ) ./ 2.0;

[a, b] = getNearest(param.asymptote, init, t_interval(cnt));

s = length(t_interval);
opts = optimset('Display', 'none', 'TolFun', param.tol, 'TolX', param.tol);
x_i = zeros(1,s);
exitflag = zeros(1,s);

[x_i(cnt),~,~,exitflag(cnt)] = lsqnonlin(@(x)F_func( ...
    t_interval(cnt), x), init, a, b, opts);
noise = init .* 0e-3 .* length(param.asymptote);
threshhold = length(t_interval) - cnt;

for i=1:threshhold

% First half
k = cnt - i;
[a, b] = getNearest(param.asymptote, x_i(k + 1), t_interval(k));
[x_i(k), ~, ~, exitflag(k)] = lsqnonlin(@(x)F_func(t_interval(k), x), ...
    x_i(k + 1) + t_interval(k) .* noise, a, b, opts);

% Second half
k = cnt + i;
[a, b] = getNearest(param.asymptote, x_i(k - 1), t_interval(k));
[x_i(k), ~, ~, exitflag(k)] = lsqnonlin(@(x)F_func(t_interval(k), x), ...
    x_i(k - 1) + t_interval(k) .* noise, a, b, opts);

end

end

function [a,b] = getNearest(asymptote, init, ti)
    for i=length(asymptote):-1:1
        asympt_temp(i) = asymptote{i}(ti);
    end
%     asympt_temp = sort(asympt_temp);
%     a = find(asympt_temp .* (asympt_temp < init), 1, 'last');
    a = asympt_temp(asympt_temp < init) - init;
    if(~isempty(a))
        a = min(abs(a)) .* sign(a) + init;
        a = a(1);
    else
        a = min(asympt_temp);
    end
%     b = find(asympt_temp .* (asympt_temp > init), 1);
    b = asympt_temp(asympt_temp > init) - init;
    if(~isempty(b))
        b = min(abs(b)) .* sign(b) + init;
        b = b(1);
    else
        b = max(asympt_temp);
    end
end