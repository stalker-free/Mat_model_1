function t_funcs = create_functional_t(c_integral,khi_plus,khi_minus)
% CREATE_FUNCTIONAL_T Creates t(x) functions.
%	T(x) = CREATE_FUNCTIONAL_T(INTEGRAL_CONSTANT, KHI+, KHI-)
%	Creates four t(x) functions, packed in 2x2 cell array.
%
%	See also CREATE_FUNC_KHI.
    function t12 = t12_plus(x)
        t12 = khi_plus(x,0);
    end

    function t22 = t22_minus(x)
        t22 = khi_minus(x,0);
    end

    function t11 = t11_plus(x)
        t11 = t12_plus(x) .* (c_integral(1) + ... 
            integral(@(y)power(t12_plus(y),-2.0),0,x,'ArrayValued',true));
    end

    function t21 = t21_minus(x)
        t21 = t22_minus(x) .* (c_integral(2) + ... 
            integral(@(y)power(t22_minus(y),-2.0),0,x,'ArrayValued',true));
    end
    t_funcs = {@t11_plus @t12_plus ; @t21_minus @t22_minus};
end

