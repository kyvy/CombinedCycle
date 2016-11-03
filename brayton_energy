function [energy_b] = brayton_energy(states, massflowrate_b)

energy_b.qin  = PARAMS.CP_AIR*(states(15).t-states(14).t);
energy_b.qout = PARAMS.CP_AIR*(states(16).t-states(17).t);
energy_b.win  = PARAMS.CP_AIR*(states(14).t-states(13).t);
energy_b.wout = PARAMS.CP_AIR*(states(15).t-states(16).t);

energy_b.Qin   = energy_b.qin*massflowrate_b;
energy_b.Qout  = energy_b.qout*massflowrate_b;
energy_b.Win   = energy_b.win*massflowrate_b;
energy_b.Wout  = energy_b.wout*massflowrate_b;

end
