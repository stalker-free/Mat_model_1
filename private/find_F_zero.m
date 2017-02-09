function [x_i, exitflag] = find_F_zero(t_interval, F_func, param)
% FIND_F_ZERO Finds x(t) zeros.
%	(x_i(t)) = FIND_F_ZERO(T_INTERVAL, F)
%   Finds x(t) zeros from expression F(t,x_i(t)) = 0.
%   _i lies in [1, quantity_of_x_zeros].
%
%	See also CREATE_FUNCTIONAL_T, CREATE_FUNC_F.
init = param.seg;
pl = ismembertol(init,param.plus,param.tol);
mi = ismembertol(init,param.minus,param.tol);
init_point = {@(t)param.seg(1) @(t)param.seg(2)};
if(sum(pl)==1)
    init_point{pl} = @(t)(init(pl) - t);
end
if(sum(mi)==1)
    init_point{mi} = @(t)(init(mi) + t);
end
s = length(t_interval);
% opts = optimoptions('fsolve', 'Display', 'none');%, ...
%    'Algorithm', 'levenberg-marquardt');
opts = optimset('Display', 'none', 'TolFun', param.tol, 'TolX', param.tol);
x_i = zeros(1,s);
exitflag = zeros(1,s);
% x_i = arrayfun(@(t)fsolve(@(x)F_func(t, x), init_point, opts), t_interval);
% [x_i(1),~,exitflag(1)] = fsolve(@(x)F_func(t_interval(1), x), init_point, opts);
% x_i(1) = fminsearch(@(x)F_func(t_interval(1), x), init_point);

threshhold = (init_point{1}(t_interval(1)) + ...
    init_point{2}(t_interval(1))) ./ 2.0;
[x_i(1), ~, ~, exitflag(1)] = lsqnonlin(@(x)F_func(t_interval(1), x), ...
   threshhold, init_point{1}(t_interval(1)), ...
   init_point{2}(t_interval(1)), opts);
threshhold = threshhold .* 1e-3;

% threshhold = (param.seg(1) + param.seg(2)) ./ 2.0;
% [x_i(1), ~, ~, exitflag(1)] = lsqnonlin(@(x)F_func(t_interval(1), x), ...
%    threshhold, param.seg(1), param.seg(2), opts);
% threshhold = threshhold .* 1e-3;

for i=2:s
%     x_i(i) = fminsearch(@(x)F_func(t_interval(i), x), x_i(i-1));
%     if(mod(t_interval(i), 1.25) <= 1e-12)
%         x_i(i) = fsolve(@(x)F_func(t_interval(i), x), init_point, opts);
%     else
%     [x_i(i), ~, exitflag(i)] = fsolve(@(x)F_func(t_interval(i), x), ...
%         x_i(i-1) + t_interval(i) .* threshhold, opts);
[x_i(i), ~, ~, exitflag(i)] = lsqnonlin(@(x)F_func(t_interval(i), x), ...
    x_i(i - 1) + t_interval(i) .* threshhold, ...
    init_point{1}(t_interval(i)), ...
    init_point{2}(t_interval(i)), opts);
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