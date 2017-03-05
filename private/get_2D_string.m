function out = get_2D_string(vX, steps, x_t, t_t)
%GET_2D_STRING Form string plot
%   OUT = GET_2D_STRING(VX, STEPS, X_T, T_T)
% Calculate the shape of the relativity string.
idx = linspace(1, length(x_t), steps);
x_int = x_t(idx);
idx2 = linspace(1, length(t_t), steps);
t_int = t_t(idx2);
first = zeros(length(t_int), length(x_int));
second = zeros(length(t_int), length(x_int));
parfor k=1:length(t_int)
    [~, first(k,:), second(k,:)] = vX(t_int(k), x_int);
end
out = {first,second};
end