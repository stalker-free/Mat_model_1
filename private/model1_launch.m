% Step 1,2

switch 1
    case 1
        F_zero = @find_F_zero;
    case 2
        F_zero = @FFZ_w_o_line_interp;
    case 3
        F_zero = @FFZ_bot_to_top;
end

[filename,dirname] = uigetfile('*.*', 'Choose file input...');
[const_plus, const_minus] = data_load( cat(2, dirname, filename) );
[x_interval, t_interval] = form_intervals(4000, -5.0, 5.0, -10.0, 10.0);

[x_i, x0, x1, x3] = model1(const_plus, const_minus, x_interval, ...
    t_interval, F_zero);

draw_x_i(t_interval, x_i);
draw_iX(x0, x1, x3, 1, length(x_interval));