function [energy] = rankine_energy(states, mf)
% kJ/kg
energy.qin67 = states(7).h - states(6).h;
energy.qin89 = (1-mf.y)*(states(9).h - states(8).h);
energy.qin  = energy.qin67 + energy.qin89;

energy.qout = (1-mf.y-mf.z)*(states(10).h - states(1).h);

energy.win12 = (1-mf.y-mf.z) * states(1).v *(states(2).p - states(1).p);
energy.win34 = (1-mf.y) * states(3).v*(states(4).p - states(3).p);
energy.win56 = states(5).v*(states(6).p - states(5).p);
energy.win    = energy.win12 + energy.win34 + energy.win56;

energy.wout78   = states(7).h - states(8).h;
energy.wout911  = (1-mf.y)*(states(9).h - states(11).h);
energy.wout1110 = (1-mf.y-mf.z)*(states(11).h - states(10).h);
energy.wout      = energy.wout78 + energy.wout911 + energy.wout1110;
          
% kW
energy.Qin  = energy.qin*PARAMS.MASS_FLOW;
energy.Qout = energy.qout*PARAMS.MASS_FLOW;
energy.Win  = energy.win*PARAMS.MASS_FLOW;
energy.Wout = energy.wout*PARAMS.MASS_FLOW;

end

