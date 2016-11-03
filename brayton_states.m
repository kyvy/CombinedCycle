function = brayton_states(states)
% Temperature on brayton cycle

states(13).t = PARAMS.BRA_LOW_TEMP;

states(14).t = PARAMS.BRA_LOW_TEMP*(PARAMS.BRA_PRESR^((PARAMS.K_AIR-1)/PARAMS.K_AIR));

states(15).t = PARAMS.BRA_PEAK_TEMP;

states(16).t = PARAMS.BRA_PEAK_TEMP/(PARAMS.BRA_PRESR^((PARAMS.K_AIR-1)/PARAMS.K_AIR));

states(17).t = PARAMS.BRA_MID_TEMP;
