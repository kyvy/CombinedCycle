function [s_curve, t_curve] = vapor_curve(p)

for n=1:length(p)
   t_curve(n) = xsteam('Tsat_p', p(n));
   s_curve(n) = xsteam('sL_p', p(n));
end

for n=length(p):-1:1
   t_curve(end+1) = xsteam('Tsat_p', p(n));
   s_curve(end+1) = xsteam('sV_p', p(n));
end

ss = linspace(round(s_curve(1)), round(s_curve(end)))';
tt = spline(s_curve,t_curve,ss);
plot(ss,tt)

end

