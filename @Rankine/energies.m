function [energy] = energies(states)

wout_turbine = @(state1, state2)  state1.mfrac * (state1.h - state2.h);
win_pump     = @(state1, state2)  state1.mfrac * state1.v * (state2.p - state1.p);


% kJ/kg
energy.qin67 =  states(7).h - states(6).h;
energy.qin89 = (states(9).h - states(8).h) * states(9).mfrac;
energy.qin   = energy.qin67 + energy.qin89;

energy.qout  = (states(10).h - states(1).h) * states(10).mfrac;

energy.win12 = win_pump(states(1), states(2));
energy.win34 = win_pump(states(3), states(4));
energy.win56 = win_pump(states(5), states(6));
energy.win   = energy.win12 + energy.win34 + energy.win56;

energy.wout78   = wout_turbine(states(7), states(8));
energy.wout910  = wout_turbine(states(9), states(10));
energy.wout911  = wout_turbine(states(9), states(11));
energy.wout     = energy.wout78 + energy.wout910 + energy.wout911;
          
% kW
energy.Qin  = energy.qin*PARAMS.MASS_FLOW;
energy.Qout = energy.qout*PARAMS.MASS_FLOW;
energy.Win  = energy.win*PARAMS.MASS_FLOW;
energy.Wout = energy.wout*PARAMS.MASS_FLOW;

end

