function t_funcs = create_functional_t(c_integral,khi_plus,khi_minus,pie)
% CREATE_FUNCTIONAL_T Creates t(x) functions.
%	T(x) = CREATE_FUNCTIONAL_T(INTEGRAL_CONSTANT, KHI+, KHI-)
%	Creates four t(x) functions, packed in 2x2 cell array.
%
%	See also CREATE_FUNC_KHI.

tol = 1e-12;
t_funcs = cell(2);
t_funcs{1,2} = @(x)t2_(khi_plus, x);
t_funcs{2,2} = @(x)t2_(khi_minus, x);
t_funcs{1,1} = @(x)t1_(c_integral(1), khi_plus, pie, tol, x);
t_funcs{2,1} = @(x)t1_(c_integral(2), khi_minus, pie, tol, x);

end


function t2 = t2_(khi, x)
    t2 = khi(x, 0);
end

function t1 = t1_(c, khi, pie, tol, x)
    t1 = c;
    ch = abs(x) > tol;
    if(any(ch))
        if(isscalar(x))
            if(x >= 0.0)
                lin = linspace(0, x, pie);
            else
                lin = linspace(x, 0, pie);
            end
        else
            lin = x(ch);
        end
        t1 = t1 + trapz(lin, power(khi(lin, 0), -2.0)); 
    end
    t1 = t1 .* khi(x, 0);
end