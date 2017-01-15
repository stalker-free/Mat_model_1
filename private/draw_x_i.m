function draw_x_i(t_interval, x_i)
% DRAW_X_I Draw x_i(t) on the 2D-plane.
% DRAW_X_I(T_INTERVAL, X_I)
%
% See also CREATE_FUNCTIONAL_T, FIND_F_ZERO.

figure
plot(x_i, t_interval)
xlabel('State')
ylabel('Time')
grid on
title('State of quaziparticles')
end

