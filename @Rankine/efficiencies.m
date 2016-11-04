function [eff] = efficiencies(states, energy)

isen_pump = @(state1, state2, win) (state2.psi - state1.psi)/win;
isen_turbine = @(state1, state2, wout) wout/(state1.psi - state2.psi);
% isen_hx = @(state1, state2, state3, state4) % heat exchanger

% pump efficiencies
eff.isen12 = isen_pump(states(1), states(2), energy.win12);
eff.isen34 = isen_pump(states(3), states(4), energy.win34);
eff.isen56 = isen_pump(states(5), states(6), energy.win56);

% turbine efficiencies
eff.isen78 = isen_turbine(states(7), states(8), energy.wout78);
eff.isen910 = isen_turbine(states(9), states(10), energy.wout910);
eff.isen911 = isen_turbine(states(9), states(11), energy.wout911);

end

