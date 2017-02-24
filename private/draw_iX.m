function draw_iX(x0,x1,x3,a,b)
% DRAW_IX(X0,X1,X3) Draw vX_i(t,x) on the 3D-plane.
%
% See also CREATE_FUNCTIONAL_T, FIND_F_ZERO, DRAW_X_I.
figure
hold on
for r = 1:length(x1(:,1))
    plot3(x1(r,a:b),x3(r,a:b),x0(r,a:b))
end
%surf(x1,x3,x0)
%plot3(x1,x3,x0)
xlabel('X1')
ylabel('X3')
zlabel('X0')
title('World lines of quaziparticles')
hold off
end

