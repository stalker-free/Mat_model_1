
[filename,dirname] = uigetfile('*.*', 'Choose file input...');
[const_plus, const_minus] = data_load(cat(2,dirname,filename));
% a_plus = create_func_a(const_plus);
% a_minus = create_func_a(const_minus);
da_plus = create_func_da(const_plus);
da_minus = create_func_da(const_minus);
x_interval = -1.0:0.01:1.0;

% syms x G(x);
gamma_plus = create_func_gamma(const_plus, da_plus, x_interval);
% syms x G(x) clear;

% syms x G(x);
gamma_minus = create_func_gamma(const_minus, da_minus, x_interval);
% syms x G(x) clear;

khi_plus = create_func_khi(const_plus, gamma_plus);
khi_minus = create_func_khi(const_minus, gamma_minus);
c_integral = [1.25 0.65];
t_matr = create_functional_t(c_integral,khi_plus,khi_minus);
F_func = create_func_F(t_matr);
t_interval = 0.0:0.01:1.0;
x_i = find_F_zero(t_interval, F_func);
draw_x_i(t_interval, x_i);
zero_vect = zeros(1,3);
vX = create_func_vX(t_matr, zero_vect, 1.0);
draw_iX(vX, t_interval, x_i);