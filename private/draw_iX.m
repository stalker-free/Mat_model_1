function [x0,x1,x3] = draw_iX(vX, t_interval, x_i)
% DRAW_IX Draw vX_i(t,x) on the 3D-plane.
% [X0,X1,X3] = DRAW_IX(VX, T_INTERVAL, X_I)
%
% See also CREATE_FUNCTIONAL_T, FIND_F_ZERO, DRAW_X_I.
x0 = zeros(size(x_i));
x1 = zeros(size(x_i));
x3 = zeros(size(x_i));

for I_ = 1:size(x_i,1)
    [x0(I_,:),x1(I_,:),x3(I_,:)] = vX(t_interval, x_i(I_,:));
end
figure
plot3(x1,x3,x0)
xlabel('X1')
ylabel('X3')
zlabel('X0')
title('World lines of quaziparticles')
end

