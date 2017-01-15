function t_funcs = create_functional_t(c_integral,khi_plus,khi_minus,pie)
% CREATE_FUNCTIONAL_T Creates t(x) functions.
%	T(x) = CREATE_FUNCTIONAL_T(INTEGRAL_CONSTANT, KHI+, KHI-)
%	Creates four t(x) functions, packed in 2x2 cell array.
%
%	See also KHI.

tol = 1e-12;
t_funcs = cell(2);
% t2
t_funcs{1,2} = @(x)khi_plus(x, 0.0);
t_funcs{2,2} = @(x)khi_minus(x, 0.0);
% t1
t_funcs{1,1} = @(x)t1_(c_integral(1), khi_plus, pie, tol, x);
t_funcs{2,1} = @(x)t1_(c_integral(2), khi_minus, pie, tol, x);

end

function t1 = t1_(c, khi, pie, tol, x)
    t1 = c;
    ch = abs(x) > tol;
    if(any(ch))
        if(isscalar(x))
            if(x >= 0.0)
               lin = linspace(0.0, x, pie);
            else
               lin = linspace(x, 0.0, pie);
            end
%             t1 = t1 - integral(@(y)power(y.*khi(1./y,0.0),-2.0),1./x,pie); 
        else
            lin = x(ch);
%             lin = 1./x(ch);
%             l1 = lin(lin >= 0.0);
%             l2 = lin(lin < 0.0);
%             t1 = t1 + trapz(l1, power(khi(l1, 0.0), -2.0)) - ...
%                 trapz(l2, power(khi(l2, 0.0), -2.0)); 
%             t1 = t1 - trapz(lin, power(khi(lin, 0.0)./lin, -2.0));
        end
        t1 = t1 + trapz(lin, power(khi(lin, 0.0), -2.0)); 
    end
    t1 = t1 .* khi(x, 0.0);
end