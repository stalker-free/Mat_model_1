function res = find_khi_zero(khi, x_interval, const)
%FIND_KHI_ZERO Summary of this function goes here
%   Detailed explanation goes here
k_interval = linspace(x_interval(1), x_interval(end), const.N + 1);

for a = length(k_interval)-1:-1:1
    res(a) = fzero(@(x)khi(x, 0.0), [k_interval(a+1),k_interval(a)]);
end

end

