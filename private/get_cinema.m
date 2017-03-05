function [cinema,scr] = get_cinema(vX, x_interval, t_interval,...
    st_x, fin_x, st_t, fin_t, parts)
%GET_CINEMA Create frames for the movie
%   [CINEMA,SCR] = GET_CINEMA(VX, X_INTERVAL, T_INTERVAL,...
%   ST_X, FIN_X, ST_T, FIN_T, PARTS)
step = (fin_t - st_t) ./ (parts - 1);
st = get_2D_string(vX,parts,x_interval(st_x:fin_x),t_interval(st_t:fin_t));

scrsz = get(groot,'ScreenSize');
scr = [scrsz(3)*0.1 scrsz(4)*0.1 scrsz(3)*0.75 scrsz(4)*0.75];
figure('Position',scr)
cinema(parts) = struct('cdata',[],'colormap',[]);
for r = 1:parts
    plot(st{2}(r,:),st{1}(r,:))
    title(cat(2, 't = ', num2str(t_interval(st_t + step .* (r - 1) )) ))
    xlabel('X3')
    ylabel('X1')
    drawnow
    cinema(r) = getframe(gcf);
end

end

