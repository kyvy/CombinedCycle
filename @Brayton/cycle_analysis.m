function [] = cycle_analysis(obj, rankine_cycle)
% 13 - [1] before compressor 
% 14 - [2] after compressor 
% 15 - [3] after combustion 
% 16 - [4] after turbine 
% 17 -     after heat exchanger

obj.states.isn(13).t = PARAMS.BRA_LOW_TEMP;
obj.states.isn(14).t = PARAMS.BRA_LOW_TEMP*(PARAMS.BRA_PRESR^((PARAMS.K_AIR-1)/PARAMS.K_AIR));
obj.states.isn(15).t = PARAMS.BRA_PEAK_TEMP;
obj.states.isn(16).t = PARAMS.BRA_PEAK_TEMP/(PARAMS.BRA_PRESR^((PARAMS.K_AIR-1)/PARAMS.K_AIR));
obj.states.isn(17).t = PARAMS.BRA_MID_TEMP;

obj.states.act(13).t = obj.states.isn(13).t;
obj.states.act(14).t = ((obj.states.isn(14).t-obj.states.isn(13).t)/0.75)+obj.states.isn(13).t;
obj.states.act(15).t = obj.states.isn(15).t;
obj.states.act(16).t = obj.states.isn(15).t-0.9*(obj.states.isn(15).t-obj.states.isn(16).t);
obj.states.act(17).t = obj.states.isn(17).t;

obj.mflow = rankine_cycle.cycle.Qin/(PARAMS.CP_AIR*(obj.states.act(16).t-obj.states.act(17).t));    

%obj.energy at each stage
obj.energy.qin  = PARAMS.CP_AIR*(obj.states.act(15).t-obj.states.act(14).t);
obj.energy.qout = PARAMS.CP_AIR*(obj.states.act(16).t-obj.states.act(17).t);
obj.energy.win  = PARAMS.CP_AIR*(obj.states.act(14).t-obj.states.act(13).t);
obj.energy.wout = PARAMS.CP_AIR*(obj.states.act(15).t-obj.states.act(16).t);

obj.energy.Qin   = obj.energy.qin*obj.mflow;
obj.energy.Qout  = obj.energy.qout*obj.mflow;
obj.energy.Win   = obj.energy.win*obj.mflow;
obj.energy.Wout  = obj.energy.wout*obj.mflow;

%exergy analysis (Kw)
obj.states.act(13).psi = obj.mflow*((PARAMS.CP_AIR*(obj.states.act(13).t-(PARAMS.DS_TEMP+273)))-(PARAMS.DS_TEMP+273)*((PARAMS.CP_AIR*log(obj.states.act(13).t/(PARAMS.DS_TEMP+273))-0.287*log(1000/(PARAMS.DS_PRES*100)))));
obj.states.act(14).psi = obj.mflow*(PARAMS.CP_AIR*(obj.states.act(14).t-(PARAMS.DS_TEMP+273))-(PARAMS.DS_TEMP+273)*(PARAMS.CP_AIR*log(obj.states.act(14).t/(PARAMS.DS_TEMP+273))-0.287*log(16000/(PARAMS.DS_PRES*100))));
obj.states.act(15).psi = obj.mflow*(PARAMS.CP_AIR*(obj.states.act(15).t-(PARAMS.DS_TEMP+273))-(PARAMS.DS_TEMP+273)*(PARAMS.CP_AIR*log(obj.states.act(15).t/(PARAMS.DS_TEMP+273))-0.287*log(16000/(PARAMS.DS_PRES*100))));
obj.states.act(16).psi = obj.mflow*(PARAMS.CP_AIR*(obj.states.act(16).t-(PARAMS.DS_TEMP+273))-(PARAMS.DS_TEMP+273)*(PARAMS.CP_AIR*log(obj.states.act(16).t/(PARAMS.DS_TEMP+273))-0.287*log(1000/(PARAMS.DS_PRES*100))));
obj.states.act(17).psi = obj.mflow*(PARAMS.CP_AIR*(obj.states.act(17).t-(PARAMS.DS_TEMP+273))-(PARAMS.DS_TEMP+273)*(PARAMS.CP_AIR*log(obj.states.act(17).t/(PARAMS.DS_TEMP+273))-0.287*log(1000/(PARAMS.DS_PRES*100))));

%Entropy analysis
obj.ds.comp = PARAMS.CP_AIR*log(obj.states.act(14).t/obj.states.act(13).t)-0.287*log(PARAMS.BRA_PRESR);
obj.ds.boil = PARAMS.CP_AIR*log(obj.states.act(15).t/obj.states.act(14).t)-0.287*log(1);
obj.ds.turb = PARAMS.CP_AIR*log(obj.states.act(16).t/obj.states.act(15).t)-0.287*log(1/PARAMS.BRA_PRESR);
obj.ds.hx = PARAMS.CP_AIR*log(obj.states.act(17).t/obj.states.act(16).t)-0.287*log(1);

%exergy destroyed
obj.xdest.comp = (PARAMS.DS_TEMP+273)*obj.ds.comp;
obj.xdest.boil = (PARAMS.DS_TEMP+273)*((obj.ds.boil*obj.mflow)-(obj.energy.Qin/obj.states.act(15).t));
obj.xdest.turb = (PARAMS.DS_TEMP+273)*obj.ds.turb;
obj.xdest.hx = (PARAMS.DS_TEMP+273)*((obj.ds.hx*obj.mflow)+(obj.energy.Qout/obj.states.act(17).t));

%2nd law efficiencies
obj.eff2.comp = (obj.states.act(14).psi-obj.states.act(13).psi)/obj.energy.Win;
obj.eff2.turb = obj.energy.Wout/(obj.states.act(15).psi-obj.states.act(16).psi);

end
