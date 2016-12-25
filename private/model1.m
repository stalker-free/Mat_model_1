
[filename,dirname] = uigetfile('*.*', 'Choose file input...');
[const_plus, const_minus] = data_load(cat(2,dirname,filename));
% a_plus = create_func_a(const_plus);
% a_minus = create_func_a(const_minus);
%const_plus = consts(2, [0.6 1.5], [0.7 -0.3]);
da_plus = create_func_da(const_plus);
da_minus = create_func_da(const_minus);
x_interval = -12.5:0.1:12.5;

gamma_plus = create_func_gamma(const_plus, da_plus, x_interval);
gamma_minus = create_func_gamma(const_minus, da_minus, x_interval);

khi_plus = create_func_khi(const_plus, gamma_plus);
khi_minus = create_func_khi(const_minus, gamma_minus);
c_integral = [1.25 0.65];
t_matr = create_functional_t(c_integral,khi_plus,khi_minus);
F_func = create_func_F(t_matr);
t_interval = 0.0:0.1:25.0;

%f_plot = zeros(1,length(t_interval));
%for f_i = 1:length(f_plot)
%    f_plot(f_i) = F_func(t_interval(f_i), x_interval(f_i));
%end
%figure
%plot(x_interval(1:length(x_interval)), f_plot)

x_i = find_F_zero(t_interval, F_func);
plot(x_i)
%draw_x_i(t_interval, x_i);
zero_vect = zeros(1,3);
vX = create_func_vX(t_matr, zero_vect, 1.0);
draw_iX(vX, t_interval, x_i);