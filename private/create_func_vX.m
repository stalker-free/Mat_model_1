function vX = create_func_vX(funcs_t, const_vect, p)
%CREATE_FUNC_VX Creates vX(t,x).
%	VX(T,X) = CREATE_FUNC_VX(FUNCS_T, CONST_VECT, P)
%   Creates vX(t,x) function for use in the graphic.
%
%	See also CREATE_FUNCTIONAL_T.

function [ax0, ax1, ax3] = vX_aux(t, x)
    
size_t = length(t);
tol = 1e-12;

if(size_t > 1)
res = zeros(3,size_t);

for k = 1:size(res,2)
b0 = const_vect(1) + p * integral(@(nu)b_0(funcs_t, nu, 1), tol, ...
    t(k)+x(k)) - p * integral(@(nu)b_0(funcs_t, nu, 2), tol, t(k) - x(k));
b1 = const_vect(2) + p * integral(@(nu)b_1(funcs_t, nu, 1), tol, ...
    t(k)+x(k)) - p * integral(@(nu)b_1(funcs_t, nu, 2), tol, t(k) - x(k));
b3 = const_vect(3) + p * integral(@(nu)b_3(funcs_t, nu, 1), tol, ...
    t(k)+x(k)) - p * integral(@(nu)b_3(funcs_t, nu, 2), tol, t(k) - x(k));

res(:,k) = [b0 b1 b3];
end

else % if(size_t > 1)
res = zeros(3,length(x));

for k = 1:size(res,2)
b0 = const_vect(1) + p * integral(@(nu)b_0(funcs_t, nu, 1), tol, ...
    t + x(k)) - p * integral(@(nu)b_0(funcs_t, nu, 2), tol, t - x(k));
b1 = const_vect(2) + p * integral(@(nu)b_1(funcs_t, nu, 1), tol, ...
    t + x(k)) - p * integral(@(nu)b_1(funcs_t, nu, 2), tol, t - x(k));
b3 = const_vect(3) + p * integral(@(nu)b_3(funcs_t, nu, 1), tol, ...
    t + x(k)) - p * integral(@(nu)b_3(funcs_t, nu, 2), tol, t - x(k));

res(:,k) = [b0 b1 b3];
end

end % if(size_t > 1)

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