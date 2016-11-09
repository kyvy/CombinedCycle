function [] = pressure_lines(states, s_curve, t_curve, line_style)

p = [states.p]; 
s = [states.s]; 
t = [states.t];

plot([s(2) s(3)], [t(2) t(3)], line_style)
plot([s(3) s(12)], [t(3) t(12)], line_style)
plot([s(4) s(5)], [t(4) t(5)], line_style)
plot([s(1) s(10)], [t(1) t(10)], line_style)
plot([s(9) s(11)], [t(9) t(11)], line_style)
plot([s(11) s(10)], [t(11) t(10)], line_style)

for n=[1, 3, 5, 7, 8]
    plot([s(n) s(n+1)], [t(n) t(n+1)], line_style)
end


plot([s_curve(4) s_curve(5)], [t_curve(4) t_curve(5)], line_style)

plot([s_curve(4) s(6)], [t_curve(4) t(6)], line_style)
plot([s_curve(5) s(7)], [t_curve(5) t(7)], line_style)
plot([s_curve(6) s(5)], [t_curve(6) t(5)], line_style)
plot([s_curve(6) s(8)], [t_curve(6) t(8)], line_style)
plot([s_curve(7) s(11)], [t_curve(7) t(11)], line_style)
plot([s_curve(7) s(12)], [t_curve(7) t(12)], line_style)

end


function [r] = dround(num, dec)
% round to decimal place
format = strcat('%.', num2str(dec), 'f');
r = str2double(sprintf(format, num));
end










