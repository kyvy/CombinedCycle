function [temp_isn,temp_act,mflow,energy,exergy,exdest,eff2] = cycle_analysis(rankine_cycle)
% 13 - [1] before compressor 
% 14 - [2] after compressor 
% 15 - [3] after combustion 
% 16 - [4] after turbine 
% 17 -     after heat exchanger

temp_isn(1) = PARAMS.BRA_LOW_TEMP;
temp_isn(2) = PARAMS.BRA_LOW_TEMP*(PARAMS.BRA_PRESR^((PARAMS.K_AIR-1)/PARAMS.K_AIR));
temp_isn(3) = PARAMS.BRA_PEAK_TEMP;
temp_isn(4) = PARAMS.BRA_PEAK_TEMP/(PARAMS.BRA_PRESR^((PARAMS.K_AIR-1)/PARAMS.K_AIR));
temp_isn(5) = PARAMS.BRA_MID_TEMP;

temp_act(1) = temp_isn(1);
temp_act(2) = ((temp_isn(2)-temp_isn(1))/0.75)+temp_isn(1);
temp_act(3) = temp_isn(3);
temp_act(4) = temp_isn(3)-0.9*(temp_isn(3)-temp_isn(4));
temp_act(5) = temp_isn(5);

mflow = rankine_cycle.cycle.Qin/(PARAMS.CP_AIR*(temp_act(4)-temp_act(5)));    

%energy at each stage
energy.qin  = PARAMS.CP_AIR*(temp_act(3)-temp_act(2));
energy.qout = PARAMS.CP_AIR*(temp_act(4)-temp_act(5));
energy.win  = PARAMS.CP_AIR*(temp_act(2)-temp_act(1));
energy.wout = PARAMS.CP_AIR*(temp_act(3)-temp_act(4));

energy.Qin   = energy.qin*mflow;
energy.Qout  = energy.qout*mflow;
energy.Win   = energy.win*mflow;
energy.Wout  = energy.wout*mflow;

%exergy analysis (Kw)
exergy(1) = mflow*((PARAMS.CP_AIR*(temp_act(1)-(PARAMS.DS_TEMP+273)))-(PARAMS.DS_TEMP+273)*((PARAMS.CP_AIR*log(temp_act(1)/(PARAMS.DS_TEMP+273))-0.287*log(1000/(PARAMS.DS_PRES*100)))));
exergy(2) = mflow*(PARAMS.CP_AIR*(temp_act(2)-(PARAMS.DS_TEMP+273))-(PARAMS.DS_TEMP+273)*(PARAMS.CP_AIR*log(temp_act(2)/(PARAMS.DS_TEMP+273))-0.287*log(16000/(PARAMS.DS_PRES*100))));
exergy(3) = mflow*(PARAMS.CP_AIR*(temp_act(3)-(PARAMS.DS_TEMP+273))-(PARAMS.DS_TEMP+273)*(PARAMS.CP_AIR*log(temp_act(3)/(PARAMS.DS_TEMP+273))-0.287*log(16000/(PARAMS.DS_PRES*100))));
exergy(4) = mflow*(PARAMS.CP_AIR*(temp_act(4)-(PARAMS.DS_TEMP+273))-(PARAMS.DS_TEMP+273)*(PARAMS.CP_AIR*log(temp_act(4)/(PARAMS.DS_TEMP+273))-0.287*log(1000/(PARAMS.DS_PRES*100))));
exergy(5) = mflow*(PARAMS.CP_AIR*(temp_act(5)-(PARAMS.DS_TEMP+273))-(PARAMS.DS_TEMP+273)*(PARAMS.CP_AIR*log(temp_act(5)/(PARAMS.DS_TEMP+273))-0.287*log(1000/(PARAMS.DS_PRES*100))));

%Entropy analysis
ds.comp = PARAMS.CP_AIR*log(temp_act(2)/temp_act(1))-0.287*log(PARAMS.BRA_PRESR);
ds.boil = PARAMS.CP_AIR*log(temp_act(3)/temp_act(2))-0.287*log(1);
ds.turb = PARAMS.CP_AIR*log(temp_act(4)/temp_act(3))-0.287*log(1/PARAMS.BRA_PRESR);
ds.hx = PARAMS.CP_AIR*log(temp_act(5)/temp_act(4))-0.287*log(1);

%exergy destroyed
exdest.comp = (PARAMS.DS_TEMP+273)*ds.comp;
exdest.boil = (PARAMS.DS_TEMP+273)*((ds.boil*mflow)-(energy.Qin/temp_act(3)));
exdest.turb = (PARAMS.DS_TEMP+273)*ds.turb;
exdest.hx = (PARAMS.DS_TEMP+273)*((ds.hx*mflow)+(energy.Qout/temp_act(5)));

%2nd law efficiencies
eff2.comp = (exergy(2)-exergy(1))/energy.Win;
eff2.turb = energy.Wout/(exergy(3)-exergy(4));

end
