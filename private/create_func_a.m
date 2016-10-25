function a = create_func_a(const)
% CREATE_FUNC_A Creates a(k).
%	A(k) = CREATE_FUNC_A(CONSTANTS)	Creates a(k) function for further use.
%
%	Constants are:
%	N+, N- -- quantities of number sets. Must be positive integers.
%
%	Happa+, Happa- -- eigenvalues. Must be positive.
%
%	b+, b- -- factor before reversed exponent.
%	Elements with odd index must be positive, even -- negative.
%
%	See also DATA_LOAD, class CONST.
    function a_val = a_aux(k)
        a_val = 1;
        for n = 1:const.N
            a_val = a_val .* (k - 1i .* const.happa(n)) / ...
                (k + 1i .* const.happa(n));
        end
    end
    a = @a_aux;
end

