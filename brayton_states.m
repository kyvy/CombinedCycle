function [massflowrate_b] = brayton_states(energy)
% Temperature on brayton cycle


states_b(13).t = PARAMS.BRA_LOW_TEMP;

states_b(14).t = PARAMS.BRA_LOW_TEMP*(PARAMS.BRA_PRESR^((PARAMS.K_AIR-1)/PARAMS.K_AIR));

states_b(15).t = PARAMS.BRA_PEAK_TEMP;

states_b(16).t = PARAMS.BRA_PEAK_TEMP/(PARAMS.BRA_PRESR^((PARAMS.K_AIR-1)/PARAMS.K_AIR));

states_b(17).t = PARAMS.BRA_MID_TEMP;

massflowrate_b = energy.Qin/(PARAMS.CP_AIR*(states_b(16).t-states_b(17).t));    %not sure if i can call energy.Qin from here. (from rankine_energy)

end
