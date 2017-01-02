function gamma = create_func_gamma(const, da_func, x_interval)
% CREATE_FUNC_GAMMA Generates bundle of functions.
%   [GAMMA] = CREATE_FUNC_GAMMA(CONSTANTS,DA) Generates bundle of
%   functions through the solution of linear algebraic system.
%
%	Constants are:
%	N+, N- -- quantities of number sets. Must be positive integers.
%
%	Happa+, Happa- -- eigenvalues. Must be positive.
%
%	b+, b- -- factor before reversed exponent.
%	Elements with odd index must be positive, even -- negative.
%
%	See also CREATE_FUNC_DA, SPLINE, class CONST.

% Solve Cx = B algebraic equation
function B_val = B(n, x_m)
 B_val = exp(-2.0 * const.happa(n) * x_m);

 for m = n
  B_val(m,:) = ...
     B_val(m,:) .* const.b(m) ./ da_func(1i * const.happa(m));
 end

end

% Get values from solution function...
B_temp = B(1:const.N, x_interval);
%C = cell(1,size(x_interval,2));
%for k = 1:size(C,2)
C = cell(1,length(x_interval));
for k = 1:length(C)
    C{k} = eye(const.N, const.N);
    for i_ = 1:const.N
        %b = 1i .* B(i, x_interval(k));
        for j_ = 1:const.N
            C{k}(i_,j_) = C{k}(i_,j_) - 1i .* ...
                B_temp(i_,k) ./ (const.happa(i_) + const.happa(j_));
        end
    end
end

gamma_aux = zeros(size(B_temp));
for k = 1:size(C,2)
    gamma_aux(:,k) = C{k} \ B_temp(:,k);
end
%gamma = gamma_aux;
%figure
%plot(x_interval, imag(gamma_aux), '-')

% ...and present them as "continuous function"
gamma = cell(1, const.N);
spl = cell(1, const.N);
for k = 1:const.N
   %spl{k} = spline(x_interval, gamma_aux(k,:));
   %gamma{k} = @(x)ppval(spl{k}, x);
   spl{k} = griddedInterpolant(x_interval, gamma_aux(k,:), 'spline');
   gamma{k} = @(x)spl{k}(x);
   %gamma{k} = @(x)power((x - 2 + 0.3i),-exp(1.0));
end
end
% function val = gamma_f(g_v, x)
%     tol = 1e-12;
%     found_s = ismembertol(x_interval, x, tol);
%     val = g_v(found_s);
% end
% 
% gamma = cell(1,const.N);
% for k = 1:const.N
%     gamma{k} = @(x)gamma_f(gamma_aux(k,:),x);
% end
% 
% end