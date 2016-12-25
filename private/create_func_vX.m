function vX = create_func_vX(funcs_t, const_vect, p)
%CREATE_FUNC_VX Creates vX(t,x).
%	VX(T,X) = CREATE_FUNC_VX(FUNCS_T, CONST_VECT, P)
%   Creates vX(t,x) function for use in the graphic.
%
%	See also CREATE_FUNCTIONAL_T.
    function [b0, b1, b3] = e_aux(nu,i)
        b0 = 0.5 * (power(funcs_t{i,1}(nu), 2.0) + ...
            power(funcs_t{i,2}(nu),2.0));
        b1 = -(funcs_t{i,1}(nu) * funcs_t{i,2}(nu));
        b3 = -0.5 * (power(funcs_t{i,1}(nu),2.0) - ...
            power(funcs_t{i,2}(nu), 2.0));
    end

    function [ax0, ax1, ax3] = vX_aux(t,x)
        res = zeros(3,length(t));
        for k = 1:length(res)
            res(:,k) = const_vect + ...
              p * integral(@(nu)e_aux(nu, 1), 0, t(k) + x(k), ...
              'ArrayValued',true) - p * integral(@(nu)e_aux(nu, 2), ...
              0, t(k) - x(k), 'ArrayValued',true);
        end
        ax0 = res(1,:);
        ax1 = res(2,:);
        ax3 = res(3,:);
    end
    vX = @vX_aux;
end
