function [massflowrate_b,energy_b,exergy_b] = brayton_states(rankine_cycle)
% Temperature on brayton cycle

temp(1) = PARAMS.BRA_LOW_TEMP;

temp(2) = PARAMS.BRA_LOW_TEMP*(PARAMS.BRA_PRESR^((PARAMS.K_AIR-1)/PARAMS.K_AIR));

temp(3) = PARAMS.BRA_PEAK_TEMP;

temp(4) = PARAMS.BRA_PEAK_TEMP/(PARAMS.BRA_PRESR^((PARAMS.K_AIR-1)/PARAMS.K_AIR));

temp(5) = PARAMS.BRA_MID_TEMP;

massflowrate_b = rankine_cycle.total.Qin/(PARAMS.CP_AIR*(temp(4)-temp(5)));    

%energy at each stage
energy_b.qin  = PARAMS.CP_AIR*(temp(3)-temp(2));
energy_b.qout = PARAMS.CP_AIR*(temp(4)-temp(5));
energy_b.win  = PARAMS.CP_AIR*(temp(2)-temp(1));
energy_b.wout = PARAMS.CP_AIR*(temp(3)-temp(4));

energy_b.Qin   = energy_b.qin*massflowrate_b;
energy_b.Qout  = energy_b.qout*massflowrate_b;
energy_b.Win   = energy_b.win*massflowrate_b;
energy_b.Wout  = energy_b.wout*massflowrate_b;

%exergy analysis (Kj)
exergy_b(1) = massflowrate_b*((PARAMS.CP_AIR*(temp(1)-(PARAMS.DS_TEMP+273)))-(PARAMS.DS_TEMP+273)*((PARAMS.CP_AIR*log(temp(1)/(PARAMS.DS_TEMP+273))-0.287*log(1000/(PARAMS.DS_PRES*100)))))
exergy_b(2) = massflowrate_b*(PARAMS.CP_AIR*(temp(2)-(PARAMS.DS_TEMP+273))-(PARAMS.DS_TEMP+273)*(PARAMS.CP_AIR*log(temp(2)/(PARAMS.DS_TEMP+273))-0.287*log(16000/(PARAMS.DS_PRES*100))))
exergy_b(3) = massflowrate_b*(PARAMS.CP_AIR*(temp(3)-(PARAMS.DS_TEMP+273))-(PARAMS.DS_TEMP+273)*(PARAMS.CP_AIR*log(temp(3)/(PARAMS.DS_TEMP+273))-0.287*log(16000/(PARAMS.DS_PRES*100))))
exergy_b(4) = massflowrate_b*(PARAMS.CP_AIR*(temp(4)-(PARAMS.DS_TEMP+273))-(PARAMS.DS_TEMP+273)*(PARAMS.CP_AIR*log(temp(4)/(PARAMS.DS_TEMP+273))-0.287*log(1000/(PARAMS.DS_PRES*100))))
exergy_b(5) = massflowrate_b*(PARAMS.CP_AIR*(temp(5)-(PARAMS.DS_TEMP+273))-(PARAMS.DS_TEMP+273)*(PARAMS.CP_AIR*log(temp(5)/(PARAMS.DS_TEMP+273))-0.287*log(1000/(PARAMS.DS_PRES*100))))

%2nd law efficiencies


end
