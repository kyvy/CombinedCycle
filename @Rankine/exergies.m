function [states, energy, xdest] = exergies(states, energy)
% calculate exergy (psi) at each state and exergy destroyed

% calculate exergy at each state (kJ/kg)
psi = @(state) state.mfrac * ((state.h - PARAMS.DS_ENTHALPY) - (PARAMS.DS_TEMP+273)*(state.s - PARAMS.DS_ENTROPY));
for i=1:12; states(i).psi = psi(states(i)); end  

% calculate exergy destroyed (kJ/kg)
xdest_turbine = @(state1, state2, wout12)  state1.mfrac * (state1.psi - state2.psi) - wout12;
xdest_pump    = @(state1, state2, win12)   state1.mfrac * (state2.psi - state1.psi) + win12;

xdest.x12 = xdest_pump(states(1), states(2), energy.win12);
xdest.x34 = xdest_pump(states(3), states(4), energy.win34);
xdest.x56 = xdest_pump(states(5), states(6), energy.win56);

xdest.x78  = xdest_turbine(states(7), states(8),  energy.wout78);
xdest.x911 = xdest_turbine(states(9), states(11), energy.wout911);
xdest.x910 = xdest_turbine(states(9), states(10), energy.wout910);

wrev_turbine  = @(state1, state2)  state1.mfrac * (state1.psi - state2.psi);
wrev_pump     = @(state1, state2)  state1.mfrac * (state2.psi - state1.psi);

energy.win12_rev = wrev_pump(states(1), states(2));
energy.win34_rev = wrev_pump(states(3), states(4));
energy.win56_rev = wrev_pump(states(5), states(6));

energy.wout78_rev  = wrev_turbine(states(7), states(8));
energy.wout910_rev = wrev_turbine(states(9), states(10));
energy.wout911_rev = wrev_turbine(states(9), states(11));



end


