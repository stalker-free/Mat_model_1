function draw_iX(x0,x1,x3)
% DRAW_IX(X0,X1,X3) Draw vX_i(t,x) on the 3D-plane.
%
% See also CREATE_FUNCTIONAL_T, FIND_F_ZERO, DRAW_X_I.
len = length(x1(:,1));
limits = [-len./2.0 len./2.0];
figure
hold on
for r = 1:len    
    x0_mod = x0(r,:);
    x1_mod = x1(r,:);
    x3_mod = x3(r,:);
    left = x0_mod >= limits(1);
    right = x0_mod < limits(2);
    x0_mod = x0_mod(left & right);
    x1_mod = x1_mod(left & right);
    x3_mod = x3_mod(left & right);
    plot3(x1_mod, x3_mod, x0_mod, 'LineWidth', 3.0)
end
%surf(x1,x3,x0)
%plot3(x1,x3,x0)
xlabel('X1')
ylabel('X3')
zlabel('X0')
title('World lines of quaziparticles')
hold off
end

