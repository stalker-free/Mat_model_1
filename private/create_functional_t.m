function t_funcs = create_functional_t(c_integral, conf, ...
    khi_plus, khi_minus, pie, plus_zero, minus_zero)
% CREATE_FUNCTIONAL_T Creates t(x) functions.
%	T(x) = CREATE_FUNCTIONAL_T(INTEGRAL_CONSTANT, KHI+, KHI-)
%	Creates four t(x) functions, packed in 2x2 cell array.
%
%	See also CREATE_FUNC_KHI.

tol = 1e-12;
t_funcs = cell(2);
t_funcs{1,2} = @(x)t2_(khi_plus, x);
t_funcs{2,2} = @(x)t2_(khi_minus, x);
t_funcs{1,1} = @(x)t1_(c_integral(1), khi_plus, plus_zero, pie, ...
    tol, conf, x);
t_funcs{2,1} = @(x)t1_(c_integral(2), khi_minus, minus_zero, pie, ...
    tol, conf, x);

end

function t2 = t2_(khi, x)
    t2 = khi(x, 0.0);
end

function t1 = t1_(c, khi, zero, pie, tol, cf, x)
    t1 = c;
    ch = abs(x) > tol;
if(any(ch))
    if(isscalar(x))
        if(x >= 0.0)
            %lin = linspace(0.0, x, pie);
          % lin = [0.0-cf zero(zero > 0.0) (x+cf)];
            lin = [-cf zero(zero >= 0.0 & zero <= x) (x+cf)];
        else
            %lin = linspace(x, 0.0, pie);
          % lin = [(x-cf) zero(zero < 0.0) 0.0+cf];
            lin = [(x-cf) zero(zero >= x & zero < 0.0) cf];
        end
        for li = 1:length(lin)-1
            pies = linspace(lin(li) + cf, lin(li+1) - cf, pie);
            t1 = t1 + trapz(pies, power(khi(pies, 0.0), -2.0));
        end
    else
        prelin = x(ch);
        if(all(prelin >= 0.0))
          lin = [(prelin(1)-cf) zero(zero >= 0.0 & zero <= prelin(end)) ...
                (prelin(end)+cf)];
        else
          lin = [(prelin(1)-cf) zero(zero >= prelin(1) & zero < 0.0) ...
                (prelin(end)+cf)];
        end
        for li = 1:length(lin)-1
            pies = prelin( (prelin >= (lin(li) + cf)) & ...
                (prelin <= (lin(li+1) - cf)) );
            t1 = t1 + trapz(pies, power(khi(pies, 0.0), -2.0), 2);
        end
    end
%     powered_khi = power(khi(lin, 0.0), -2.0);
%     m = mean(powered_khi);
%     powered_khi(powered_khi > m) = m .* ...
%         (powered_khi(powered_khi > m) - min(powered_khi)) ./ ...
%         (max(powered_khi) - min(powered_khi));
%     t1 = t1 + trapz(lin, powered_khi);
%     t1 = t1 - trapz(lin, power(exp(1.0) + khi(lin, 0.0), -2.0) - ...
%         1 ./ (exp(2.0) + 2.0 .* exp(1.0) .* khi(lin, 0.0)) ); 
end
    t1 = t1 .* khi(x, 0.0);
end