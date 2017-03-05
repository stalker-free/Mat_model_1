function [x_i, x0, x1, x3, vX] = model1(const_plus, const_minus, ...
    x_interval, t_interval, F_zero)
% MODEL1 Start relativity string modelling
%   [X_I, X0, X1, X3, VX] = MODEL1(CONST_PLUS, CONST_MINUS, ...
%    X_INTERVAL, T_INTERVAL, F_ZERO)



% Step 3
% a_plus = create_func_a(const_plus);
% a_minus = create_func_a(const_minus);
da_plus = create_func_da(const_plus);
da_minus = create_func_da(const_minus);
% Step 4
gamma_plus = create_func_gamma(const_plus, da_plus, x_interval);
gamma_minus = create_func_gamma(const_minus, da_minus, x_interval);
% Step 5
khi_plus = @(x, k)khi(const_plus, gamma_plus, x, k);
khi_minus = @(x, k)khi(const_minus, gamma_minus, x, k);
% Step 6
% c_integral = [1.25 0.65];

pieces = 1500;
poolobj = gcp();
tol = 1e-4;
plus_zero = find_khi_zero(khi_plus, x_interval, pieces, tol);
minus_zero = find_khi_zero(khi_minus, x_interval, pieces, tol);
if(isempty(plus_zero) || isempty(minus_zero))
    disp('Zeros of khi haven`t been found.');
    return;
end

% d_plus = diff(khi_plus(x_interval,0.0))./(x_interval(2)-x_interval(1));
% d_minus = diff(khi_minus(x_interval,0.0))./(x_interval(2)-x_interval(1));
d_plus = @(x, k)dKhi(const_plus, gamma_plus, x, k);
d_minus = @(x, k)dKhi(const_minus, gamma_minus, x, k);
t_matr = create_functional_t(x_interval, khi_plus, khi_minus, d_plus, d_minus);
% t_matr = create_functional_t(c_integral, 0.1, khi_plus, khi_minus, ...
%     pieces, plus_zero, minus_zero);
% Step 7
[f_plus, f_minus] = determinate_T(t_matr);
F_func = @(t, x)(f_minus(t, x) - f_plus(t, x));
% F_f = generate_T_values(F_func, t_interval, x_interval);
% mesh(x_interval,t_interval,F_f);

% f_plot = zeros(1,length(t_interval));
% for f_i = 1:length(f_plot)
%    f_plot(f_i) = F_func(t_interval(f_i), x_interval(f_i));
% end
% figure
% plot(x_interval(1:length(x_interval)), f_plot)

% Step 8,9
stationary_points = sort(uniquetol([(x_interval(1) + t_interval(1)) ...
  plus_zero minus_zero (x_interval(end) + t_interval(end))], tol)) + 1e-10;

wave_count = length(stationary_points) - 1;
asymptote_points = cell(1, wave_count + 1);
for idx = 1:length(stationary_points)
    if(sum(ismembertol(stationary_points(idx), plus_zero, tol)) > 0)
        asymptote_points{idx} = @(t)(stationary_points(idx) - t);
    elseif(sum(ismembertol(stationary_points(idx), minus_zero, tol)) > 0)
        asymptote_points{idx} = @(t)(stationary_points(idx) + t);
    else
        asymptote_points{idx} = @(t)(stationary_points(idx) .* ...
            (1.0 + sqrt( 1.0 + abs(t) ) ) );
    end
end

x_i = zeros(wave_count, length(t_interval));
exitflag = zeros(wave_count, length(t_interval));
zero_vect = zeros(1,3);
vX = create_func_vX(t_matr, zero_vect, 1.0);
x0 = zeros(size(x_i));
x1 = zeros(size(x_i));
x3 = zeros(size(x_i));

for idx = wave_count:-1:1
    param = struct;
    param.idx = idx;
    param.asymptote = asymptote_points;
    param.center = ceil(length(t_interval)./2);
    param.tol = tol;
    fObj(idx) = parfeval(poolobj, F_zero, 2, ...
       t_interval, F_func, param );
end
for idx = wave_count:-1:1
   [completedIdx,value,extval] = fetchNext(fObj);
   x_i(completedIdx,:) = value;
   exitflag(completedIdx,:) = extval;
   fObj2(idx) = parfeval(poolobj, vX, 3, t_interval, x_i(completedIdx,:));
end

% Step 10
for idx = 1:wave_count
   [completedIdx,v0,v1,v3] = fetchNext(fObj2);
   x0(completedIdx,:) = v0;
   x1(completedIdx,:) = v1;
   x3(completedIdx,:) = v3;
end

% delete(poolobj)
clear fObj fObj2

end