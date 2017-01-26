% Step 1,2
[filename,dirname] = uigetfile('*.*', 'Choose file input...');
[const_plus, const_minus] = data_load(cat(2,dirname,filename));
%const_plus = consts(2, [0.6 1.5], [0.7 -0.3]);
% Step 3
% a_plus = create_func_a(const_plus);
% a_minus = create_func_a(const_minus);
da_plus = create_func_da(const_plus);
da_minus = create_func_da(const_minus);
[x_interval, t_interval] = form_intervals(2000, -3.0, 3.0, 0.0, 2.0);
% Step 4
gamma_plus = create_func_gamma(const_plus, da_plus, x_interval);
gamma_minus = create_func_gamma(const_minus, da_minus, x_interval);
% Step 5
khi_plus = @(x, k)khi(const_plus, gamma_plus, x, k);
khi_minus = @(x, k)khi(const_minus, gamma_minus, x, k);
% Step 6
c_integral = [1.25 0.65];
pieces = 1500;
% plus_zero = find_khi_zero(khi_plus, x_interval, const_plus);
% minus_zero = find_khi_zero(khi_minus, x_interval, const_minus);
% d_plus = diff(khi_plus(x_interval,0.0))./(x_interval(2)-x_interval(1));
% d_minus = diff(khi_minus(x_interval,0.0))./(x_interval(2)-x_interval(1));
d_plus = @(x, k)dKhi(const_plus, gamma_plus, x, k);
d_minus = @(x, k)dKhi(const_minus, gamma_minus, x, k);
t_matr = create_functional_t(khi_plus, khi_minus, d_plus, d_minus);
% t_matr = create_functional_t(c_integral, 0.1, khi_plus, khi_minus, ...
%     pieces, plus_zero, minus_zero);
% Step 7
F_func = @(t, x)determinate_T(t_matr, t, x);
% F_f = generate_T_values(F_func, t_interval, x_interval);
% mesh(x_interval,t_interval,F_f);

% f_plot = zeros(1,length(t_interval));
% for f_i = 1:length(f_plot)
%    f_plot(f_i) = F_func(t_interval(f_i), x_interval(f_i));
% end
% figure
% plot(x_interval(1:length(x_interval)), f_plot)
% Step 8,9
wave_count = const_plus.N + const_minus.N;

init_point = linspace(x_interval(1) - 1e-12, x_interval(end) + 1e-12, ...
    wave_count + 1);
init_point = (init_point(2:end) + init_point(1:end-1)) ./ 2;
% init_point = sort([plus_zero minus_zero]) + 1e-10;

x_i = zeros(wave_count, length(t_interval));

zero_vect = zeros(1,3);
vX = create_func_vX(t_matr, zero_vect, 1.0, pieces);
x0 = zeros(size(x_i));
x1 = zeros(size(x_i));
x3 = zeros(size(x_i));

poolobj = gcp();
for idx = wave_count:-1:1
   fObj(idx) = parfeval(poolobj, @find_F_zero, 1, ...
       t_interval, F_func, init_point(idx) );
end
for idx = wave_count:-1:1
   [completedIdx,value] = fetchNext(fObj);
   x_i(completedIdx,:) = value;
   fObj2(idx) = parfeval(poolobj, vX, 3, t_interval, x_i(completedIdx,:));
end

draw_x_i(t_interval, x_i);
% Step 10
for idx = 1:wave_count
   [completedIdx,v0,v1,v3] = fetchNext(fObj2);
   x0(completedIdx,:) = v0;
   x1(completedIdx,:) = v1;
   x3(completedIdx,:) = v3;
end

draw_iX(x0,x1,x3);
% delete(poolobj)
clear fObj fObj2