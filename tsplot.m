function [] = tsplot()

p_isn = [0.0424668834054806;6.89476000000000;6.89476000000000;16.9744033813477;16.9744033813477;160;160;16.9744033813477;16.9744033813477;0.0424668834054806;6.89476000000000;6.89476000000000];
t_isn = [30.0214539117812;30.0354835499604;114.773703119165;114.853360717606;204.245238726557;206.695297344831;550;218.534878499160;550.000387268141;30;402.160968718318;164.366101022899];
s_isn = [0.4370;0.4370;1.47061753181575;1.47060665210953;2.37080863338068;2.37102402052396;6.48324902457974;6.48324902457974;7.65058209922089;7.65058209922089;7.65058209922089;1.98626444552525];

for n=1:length(p_isn)
    p_isn(n) = dround(p_isn(n), 4);
    t_isn(n) = dround(t_isn(n), 4);
    s_isn(n) = dround(s_isn(n), 4);
end

figure()
hold on
[s_curve, t_curve] = draw_curve(p_isn);
draw_lines(s_isn, t_isn, s_curve, t_curve)

plot(s_isn, t_isn, 's')
for n=7:11
    t = text(s_isn(n)+s_isn(n)*.015,t_isn(n),num2str(n));
    t.FontSize = 10;
    t.HorizontalAlignment = 'left';
end

for n=1:6
    t = text(s_isn(n)-.1*s_isn(n),t_isn(n)+.1*t_isn(n),num2str(n));
    t.FontSize = 10;
    t.HorizontalAlignment = 'center';
end

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

plot([s(2) s(12)], [t(2) t(12)], linestyle)
plot([s(4) s(5)], [t(4) t(5)], linestyle)

for n=[1, 3, 5, 7, 8, 9]
    plot([s(n) s(n+1)], [t(n) t(n+1)], linestyle)
end

for n=2:4 % top 3 pressure lines
    plot([s_curve(n) s_curve(end+1-n)], [t_curve(n) t_curve(end+1-n)], linestyle)
end

% bottom pressure line
plot([s_curve(1) s(10)], [t_curve(1) t(10)], linestyle)

plot([s_curve(4) s(6)], [t_curve(4) t(6)], linestyle)
plot([s_curve(5) s(7)], [t_curve(5) t(7)], linestyle)
plot([s_curve(6) s(8)], [t_curve(6) t(8)], linestyle)
plot([s_curve(7) s(11)], [t_curve(7) t(11)], linestyle)

end

function [r] = dround(num, dec)
% round to decimal place
format = strcat('%.', num2str(dec), 'f');
r = str2double(sprintf(format, num));
end










