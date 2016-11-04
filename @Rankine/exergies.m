function [states, energy, xdest] = exergies(states, energy, mf)
% calculate exergy (psi) at each state and exergy destroyed (kW)

% calculate exergy at each state
psi = @(state) (state.h - PARAMS.DS_ENTHALPY) - PARAMS.DS_TEMP*(state.s - PARAMS.DS_ENTROPY);
for i=1:12; states(i).psi = psi(states(i)); end  

% calculate exergy destroyed
xdest_turbine = @(state1, state2, mfrac, wout12)  mfrac * (state1.psi - state2.psi) - wout12;
xdest_pump    = @(state1, state2, mfrac, win12)   mfrac * (state2.psi - state1.psi) + win12;

xdest.x12 = xdest_pump(states(1), states(2), energy.win12, 1-mf.y-mf.z);
xdest.x34 = xdest_pump(states(3), states(4), energy.win34, 1-mf.y);
xdest.x56 = xdest_pump(states(5), states(6), energy.win56, 1);

xdest.x78 = xdest_turbine(states(7), states(8), energy.wout78, 1);
xdest.x911 = xdest_turbine(states(9), states(11), energy.wout911, mf.z);
xdest.x910 = xdest_turbine(states(9), states(10), energy.wout910, 1-mf.y-mf.z);

wrev_turbine  = @(state1, state2, mfrac)  mfrac * (state1.psi - state2.psi);
wrev_pump     = @(state1, state2, mfrac)  mfrac * (state2.psi - state1.psi);

energy.win12_rev = wrev_pump(states(1), states(2), 1-mf.y-mf.z);
energy.win34_rev = wrev_pump(states(3), states(4), 1-mf.y);
energy.win56_rev = wrev_pump(states(5), states(6), 1);

energy.wout78_rev  = wrev_turbine(states(7), states(8), 1);
energy.wout910_rev = wrev_turbine(states(9), states(10), 1-mf.y-mf.z);
energy.wout911_rev = wrev_turbine(states(9), states(11), mf.z);



end


