function [a,b] = getNearest(asymptote, init, ti)
% GETNEAREST Find nearest to point
%   [A,B] = GETNEAREST(ASYMPTOTE, INIT, TI)
% Find nearest bounds from asymptotes to the point.
    for i=length(asymptote):-1:1
        asympt_temp(i) = asymptote{i}(ti);
    end
%     asympt_temp = sort(asympt_temp);
%     a = find(asympt_temp .* (asympt_temp < init), 1, 'last');
    a = asympt_temp(asympt_temp < init) - init;
    if(~isempty(a))
        a = min(abs(a)) .* sign(a) + init;
        a = a(1);
    else
        a = min(asympt_temp);
    end
%     b = find(asympt_temp .* (asympt_temp > init), 1);
    b = asympt_temp(asympt_temp > init) - init;
    if(~isempty(b))
        b = min(abs(b)) .* sign(b) + init;
        b = b(1);
    else
        b = max(asympt_temp);
    end
end