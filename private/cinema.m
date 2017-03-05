function cinema(F, scr)
%CINEMA Show plot animation
%   CINEMA(F,SCR)
figure('Position',scr)
movie(gcf, F, 1, 6);
end

