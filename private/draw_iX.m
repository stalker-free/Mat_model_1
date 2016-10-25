function draw_iX(vX, t_interval, x_i)
% DRAW_IX Draw vX_i(t,x) on the 3D-plane.
% DRAW_IX(VX, T_INTERVAL, X_I)
%
% See also CREATE_FUNCTIONAL_T, FIND_F_ZERO, DRAW_X_I.
[x0,x1,x3] = vX(t_interval, x_i);

figure
plot3(x1,x3,x0)
end

