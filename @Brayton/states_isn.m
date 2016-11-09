function [] = states_isn(obj)
% isentropic brayton states.isn
% 13 - [1] before compressor 
% 14 - [2] after compressor 
% 15 - [3] after combustion 
% 16 - [4] after turbine 
% 17 -     after heat exchanger

obj.states.isn(13).t = PARAMS.BRA_LOW_TEMP;
obj.states.isn(14).t = obj.states.isn(13).t * PARAMS.BRA_PRESR ^ ((PARAMS.K_AIR-1)/PARAMS.K_AIR);
obj.states.isn(15).t = PARAMS.BRA_PEAK_TEMP;
obj.states.isn(16).t = obj.states.isn(15).t / ( PARAMS.BRA_PRESR ^ ((PARAMS.K_AIR-1)/PARAMS.K_AIR) );

% assume that the heat exchanger exit temp is 50 K below rankine peak temp
obj.states.isn(17).t = PARAMS.PEAK_TEMP + 273 - 50; 

obj.states.isn(13).p = PARAMS.BRA_LOW_PRES;
obj.states.isn(14).p = PARAMS.BRA_HIGH_PRES;
obj.states.isn(15).p = PARAMS.BRA_HIGH_PRES;
obj.states.isn(16).p = PARAMS.BRA_LOW_PRES;
obj.states.isn(17).p = PARAMS.BRA_LOW_PRES;

end

