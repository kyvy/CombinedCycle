function [energy_b] = brayton_energy(massflowrate_b)

energy_b.qin  = PARAMS.CP_AIR*(states_b(15).t-states_b(14).t);
energy_b.qout = PARAMS.CP_AIR*(states_b(16).t-states_b(17).t);
energy_b.win  = PARAMS.CP_AIR*(states_b(14).t-states_b(13).t);
energy_b.wout = PARAMS.CP_AIR*(states_b(15).t-states_b(16).t);

energy_b.Qin   = energy_b.qin*massflowrate_b;
energy_b.Qout  = energy_b.qout*massflowrate_b;
energy_b.Win   = energy_b.win*massflowrate_b;
energy_b.Wout  = energy_b.wout*massflowrate_b;

end
