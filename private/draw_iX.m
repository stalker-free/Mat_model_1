function [] = draw_iX(x0,x1,x3)
% DRAW_IX(X0,X1,X3) Draw vX_i(t,x) on the 3D-plane.
%
% See also CREATE_FUNCTIONAL_T, FIND_F_ZERO, DRAW_X_I.
figure
plot3(x1,x3,x0)
xlabel('X1')
ylabel('X3')
zlabel('X0')
title('World lines of quaziparticles')
end

