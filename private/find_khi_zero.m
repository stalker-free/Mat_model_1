function res = find_khi_zero(khi, x_interval, const)
%FIND_KHI_ZERO Get zeros of khi function.
%   RES = FIND_KHI_ZERO(KHI, X_INTERVAL, CONST)
%   See also KHI, class CONST.
k_interval = linspace(x_interval(1), x_interval(end), const.N + 1);

for a = length(k_interval)-1:-1:1
    res(a) = fzero(@(x)khi(x, 0.0), [k_interval(a+1),k_interval(a)]);
end

end

