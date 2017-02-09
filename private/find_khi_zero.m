function res = find_khi_zero(khi, x_interval, pieces, tol)
%FIND_KHI_ZERO Get zeros of khi function.
%   RES = FIND_KHI_ZERO(KHI, X_INTERVAL, CONST)
%   See also KHI, class CONST.
k_interval = linspace(x_interval(1), x_interval(end), pieces);
opts = optimoptions('fsolve', 'Display', 'none');
temp_arr = nan(1,length(k_interval));
parfor a = 1:length(temp_arr)
    [temp,~,extfl] = fsolve(@(x)khi(x, 0.0), k_interval(a), opts);
    if(extfl >= 0)
        temp_arr(a) = temp;
    end
end
temp_arr(isnan(temp_arr)) = [];
temp_arr = uniquetol(temp_arr, tol);
temp_arr = temp_arr(temp_arr >= x_interval(1));
res = temp_arr(temp_arr <= x_interval(end));

end

