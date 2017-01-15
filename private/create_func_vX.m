function vX = create_func_vX(funcs_t, const_vect, p, pieces)
%CREATE_FUNC_VX Creates vX(t,x).
%	VX(T,X) = CREATE_FUNC_VX(FUNCS_T, CONST_VECT, P)
%   Creates vX(t,x) function for use in the graphic.
%
%	See also CREATE_FUNCTIONAL_T.

function [ax0, ax1, ax3] = vX_aux(t,x)
res = zeros(3,length(t));

tol = 1e-12;

for k = 1:length(res)
% b0 = const_vect(1) + p * integral(@(nu)b_0(nu, 1), tol, t(k) + x(k), ...
%     'ArrayValued', true) - p * integral(@(nu)b_0(nu, 2), tol, ...
%      t(k) - x(k), 'ArrayValued', true);
% b1 = const_vect(2) + p * integral(@(nu)b_1(nu, 1), tol, t(k) + x(k), ...
%     'ArrayValued', true) - p * integral(@(nu)b_1(nu, 2), tol, ...
%      t(k) - x(k), 'ArrayValued', true);
% b3 = const_vect(3) + p * integral(@(nu)b_3(nu, 1), tol, t(k) + x(k), ...
%     'ArrayValued', true) - p * integral(@(nu)b_3(nu, 2), tol, ...
%      t(k) - x(k), 'ArrayValued', true);
b0 = const_vect(1);
b1 = const_vect(2);
b3 = const_vect(3);
pl = t(k) + x(k);
mi = t(k) - x(k);
if(abs(pl) > tol)
    lin1 = linspace(tol, pl, pieces);
    if(pl < 0.0)
        lin1 = flip(lin1);
    end;
    b0 = b0 + p * trapz(lin1, b_0(funcs_t, lin1, 1));
    b1 = b1 + p * trapz(lin1, b_1(funcs_t, lin1, 1));
    b3 = b3 + p * trapz(lin1, b_3(funcs_t, lin1, 1));
end
if(abs(mi) > tol)
    lin2 = linspace(tol, mi, pieces);
    if(mi < 0.0)
        lin2 = flip(lin2);
    end;
    b0 = b0 - p * trapz(lin2, b_0(funcs_t, lin2, 2));
    b1 = b1 - p * trapz(lin2, b_1(funcs_t, lin2, 2));
    b3 = b3 - p * trapz(lin2, b_3(funcs_t, lin2, 2));    
end
res(:,k) = [b0 b1 b3];
end

ax0 = res(1,:);
ax1 = res(2,:);
ax3 = res(3,:);
end

vX = @vX_aux;

end


function b0 = b_0(funcs_t,nu,i)
    b0 = 0.5 * (power(funcs_t{i,2}(nu),2.0) + power(funcs_t{i,1}(nu),2.0));
end

function b1 = b_1(funcs_t,nu,i)
    b1 = -(funcs_t{i,1}(nu) .* funcs_t{i,2}(nu));
end

function b3 = b_3(funcs_t,nu,i)
    b3 = 0.5 * (power(funcs_t{i,2}(nu),2.0) - power(funcs_t{i,1}(nu),2.0));
end