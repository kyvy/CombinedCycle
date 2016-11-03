function [energy] = energies(states, mf)

wout_turbine = @(state1, state2, mfrac)  mfrac * (state1.h - state2.h);
win_pump     = @(state1, state2, mfrac)  mfrac * state1.v * (state2.p - state1.p);


% kJ/kg
energy.qin67 = states(7).h - states(6).h;
energy.qin89 = (1-mf.y)*(states(9).h - states(8).h);
energy.qin   = energy.qin67 + energy.qin89;

energy.qout  = (1-mf.y-mf.z)*(states(10).h - states(1).h);

energy.win12 = win_pump(states(1), states(2), 1-mf.y-mf.z);
energy.win34 = win_pump(states(2), states(3), 1-mf.y);
energy.win56 = win_pump(states(5), states(6), 1);
energy.win   = energy.win12 + energy.win34 + energy.win56;

energy.wout78   = wout_turbine(states(7), states(8), 1);
energy.wout910  = wout_turbine(states(9), states(10), 1-mf.y-mf.z);
energy.wout911  = wout_turbine(states(9), states(11), mf.z);
energy.wout     = energy.wout78 + energy.wout910 + energy.wout911;
          
% kW
energy.Qin  = energy.qin*PARAMS.MASS_FLOW;
energy.Qout = energy.qout*PARAMS.MASS_FLOW;
energy.Win  = energy.win*PARAMS.MASS_FLOW;
energy.Wout = energy.wout*PARAMS.MASS_FLOW;

end

