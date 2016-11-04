function [eff] = efficiencies(states, energy)

sec_pump = @(state1, state2, win) (state2.psi - state1.psi)/win;
sec_turbine = @(state1, state2, wout) wout/(state1.psi - state2.psi);
% sec_hx = @(state1, state2, state3, state4) % heat exchanger

% socond law pump efficiencies
eff.sec12 = sec_pump(states(1), states(2), energy.win12);
eff.sec34 = sec_pump(states(3), states(4), energy.win34);
eff.sec56 = sec_pump(states(5), states(6), energy.win56);

% second law turbine efficiencies
eff.sec78  = sec_turbine(states(7), states(8), energy.wout78);
eff.sec910 = sec_turbine(states(9), states(10), energy.wout910);
eff.sec911 = sec_turbine(states(9), states(11), energy.wout911);

end

