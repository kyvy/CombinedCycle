function [] = tsdiagram(rankine)

figure()
hold on

% plot saturation vapor curve
p = [rankine.states.isn(1).p, rankine.states.isn(12).p, rankine.states.isn(5).p, PARAMS.PEAK_PRES];
[s_curve, t_curve] = vapor_curve(p);

% plot pressure lines
pressure_lines(rankine.states.isn, s_curve, t_curve, 'k:')
pressure_lines(rankine.states.act, s_curve, t_curve, 'r--')

% plot states
plot([rankine.states.isn.s], [rankine.states.isn.t], 's')
plot([rankine.states.act.s], [rankine.states.act.t], 'v')


end

