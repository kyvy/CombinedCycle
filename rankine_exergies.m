function [states, xdest] = rankine_exergies(states, energy)
% calculate exergy (psi) at each state and exergy destroyed

% calculate exergy at each state
psi = @(state) (state.h - PARAMS.DS_ENTHALPY) - PARAMS.DS_TEMP*(state.s - PARAMS.DS_ENTROPY);
for i=1:12; states(i).psi = psi(states(i)); end  

% calculate exergy destroyed
xdest_turbine = @(state1, state2, mflow, wout12)  mflow * (state1.psi - state2.psi) - wout12;
xdest_pump    = @(state1, state2, mflow, win12)   mflow * (state2.psi - state1.psi) + win12;

Wrev_turbine = @(state1, state2, mflow)  mflow * (state1.psi - state2.psi);
Wrev_pump    = @(state1, state2, mflow)  mflow * (state2.psi - state1.psi);

xdest.x12 = xdest_pump(states(1), states(2), energy.win12);
xdest.x34 = xdest_pump(states(3), states(4), energy.win34);
xdest.x56 = xdest_pump(states(5), states(6), energy.win56);

xdest.x78 = xdest_turbine(states(7), states(8), energy.wout78);
xdest.x911 = xdest_turbine(states(9), states(11), energy.wout911);
xdest.x1110 = xdest_turbine(states(11), states(10), energy.wout1110);


end


