function [x_m,t_m] = form_intervals(step_size,x_start,x_end,t_start,t_end)
%FORM_INTERVALS Get square cell table of time and distance
%   [X_M,T_M] = FORM_INTERVALS(STEP_SIZE,X_START,X_END,T_START,T_END)
%   Get time and distance and divide them to equal intervals each.
assert(step_size > 0.0, 'Nonpositive step.')
assert(isnumeric([x_start, x_end, t_start, t_end]), ...
    'Non-numeric input parameters: %s \n %s \n %s \n %s', ...
    x_start, x_end, t_start, t_end)
assert(isfinite(x_start + x_end + t_start + t_end), ...
    'Invalid number input parameters: %s \n %s \n %s \n %s', ...
    x_start, x_end, t_start, t_end)
x_step = abs(x_end - x_start) / step_size;
t_step = abs(t_end - t_start) / step_size;

x_m = x_start:x_step:x_end;
t_m = t_start:t_step:t_end;
end

