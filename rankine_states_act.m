function [states, massfrac] = rankine_states_act(states, isen_states)
% calculate actual rankine states from isentropic states

mfy = @(states) (states(5).h - states(4).h)/(states(8).h - states(4).h);
mfz = @(states, y) (1 - y)*(states(3).h - states(2).h)/(states(12).h - states(2).h);

for i = [1 3 5 7 9 12]; states(i) = isen_states(i); end  % unchanges states

states(2) = pump_actual(isen_states(1), isen_states(2));
states(4) = pump_actual(isen_states(3), isen_states(4));
states(6) = pump_actual(isen_states(5), isen_states(6));

states(8)  = turbine_actual(isen_states(7), isen_states(8));
states(10) = turbine_actual(isen_states(9), isen_states(10));
states(11) = turbine_actual(isen_states(9), isen_states(11));

states(10).x = xsteam('x_ph', states(10).p, states(10).h);

massfrac.y = mfy(states);
massfrac.z = mfz(states, massfrac.y);
end


























