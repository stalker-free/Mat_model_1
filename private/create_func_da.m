function da = create_func_da(const)
% CREATE_FUNC_DA Creates da(k).
%	DA(k) = CREATE_FUNC_DA(CONSTANTS)
%   Creates derivative of function a(k) for further use.
%
%	Constants are:
%	N+, N- -- quantities of number sets. Must be positive integers.
%
%	Happa+, Happa- -- eigenvalues. Must be positive.
%
%	b+, b- -- factor before reversed exponent.
%	Elements with odd index must be positive, even -- negative.
%
%	See also CREATE_FUNC_A, class CONST.
da = @(k)da_aux(const, k);
end

function da_res = da_aux(C, k)
    da_res = 0.0;
    for n = 1:C.N
        da_val = 1.0;
        for i_ = 1:(n-1)
            da_val = da_val .* (k - 1i .* C.happa(i_)) ./ ...
                (k + 1i .* C.happa(i_));
        end
        da_val = da_val .* 2i .* C.happa(n) ./ ...
            (power(k, 2.0) + 2i .* k .* C.happa(n) - ...
            power(C.happa(n), 2.0));
        for k_ = (n+1):C.N
            da_val = da_val .* (k - 1i .* C.happa(k_)) ./ ...
                (k + 1i .* C.happa(k_));
        end
        da_res = da_res + da_val;
    end
end