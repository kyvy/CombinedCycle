function [] = cycle_analysis(obj, rankine)
% analyze the cycle using actual enthalpies (not isentropic enthalpies)
% 13 - [1] before compressor 
% 14 - [2] after compressor 
% 15 - [3] after combustion 
% 16 - [4] after turbine 
% 17 -     after heat exchanger

obj.mflow = rankine.cycle.Qin/( PARAMS.CP_AIR*(obj.states.act(16).t-obj.states.act(17).t) );

obj.energy.qin  = PARAMS.CP_AIR*(obj.states.act(15).t-obj.states.act(14).t);
obj.energy.qout = PARAMS.CP_AIR*(obj.states.act(16).t-obj.states.act(17).t);
obj.energy.win  = PARAMS.CP_AIR*(obj.states.act(14).t-obj.states.act(13).t);
obj.energy.wout = PARAMS.CP_AIR*(obj.states.act(15).t-obj.states.act(16).t);

obj.energy.Qin  = obj.energy.qin*obj.mflow;
obj.energy.Qout = obj.energy.qout*obj.mflow;
obj.energy.Win  = obj.energy.win*obj.mflow;
obj.energy.Wout = obj.energy.wout*obj.mflow;


end

