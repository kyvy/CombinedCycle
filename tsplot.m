function [] = tsplot(states)

for n=1:length(states)
    p(n) = dround(states(n).p, 2);
    t(n) = dround(states(n).t, 2);
    s(n) = dround(states(n).s, 2);
end

figure()
hold on
[s_curve, t_curve] = draw_curve(p);
draw_lines(s, t, s_curve, t_curve)

plot(s, t, 's')
% for n=7:11
%     t = text(s(n)+s(n)*.015,t(n),num2str(n));
%     t.FontSize = 10;
%     t.HorizontalAlignment = 'left';
% end
% 
% for n=[1:6,12]
%     t = text(s(n)-.1*s(n),t(n)+.1*t(n),num2str(n));
%     t.FontSize = 10;
%     t.HorizontalAlignment = 'center';
% end

end

function [s_curve, t_curve] = draw_curve(p_)
p = [p_(1), p_(12), p_(5), PARAMS.PEAK_PRES];

for n=1:length(p)
   t_curve(n) = xsteam('Tsat_p', p(n));
   s_curve(n) = xsteam('sL_p', p(n));
end

for n=length(p):-1:1
   t_curve(end+1) = xsteam('Tsat_p', p(n));
   s_curve(end+1) = xsteam('sV_p', p(n));
end

ss = linspace(round(s_curve(1)), round(s_curve(end)));
tt = spline(s_curve,t_curve,ss);

plot(ss,tt)

end

function [] = draw_lines(s, t, s_curve, t_curve)
linestyle = 'k:';

plot([s(2) s(3)], [t(2) t(3)], linestyle)
plot([s(3) s(12)], [t(3) t(12)], linestyle)
plot([s(4) s(5)], [t(4) t(5)], linestyle)
plot([s(1) s(10)], [t(1) t(10)], linestyle)

for n=[1, 3, 5, 7, 8, 9]
    plot([s(n) s(n+1)], [t(n) t(n+1)], linestyle)
end


plot([s_curve(4) s_curve(5)], [t_curve(4) t_curve(5)], linestyle)

plot([s_curve(4) s(6)], [t_curve(4) t(6)], linestyle)
plot([s_curve(5) s(7)], [t_curve(5) t(7)], linestyle)
plot([s_curve(6) s(5)], [t_curve(6) t(5)], linestyle)
plot([s_curve(6) s(8)], [t_curve(6) t(8)], linestyle)
plot([s_curve(7) s(11)], [t_curve(7) t(11)], linestyle)
plot([s_curve(7) s(12)], [t_curve(7) t(12)], linestyle)

end

function [r] = dround(num, dec)
% round to decimal place
format = strcat('%.', num2str(dec), 'f');
r = str2double(sprintf(format, num));
end










