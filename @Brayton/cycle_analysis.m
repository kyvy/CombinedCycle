function [tempisn,temp,massflowrate_b,energy_b,exergy_b,xdest_b,n] = cycle_analysis(rankine_cycle)
% 13 - [1] before compressor 
% 14 - [2] after compressor 
% 15 - [3] after combustion 
% 16 - [4] after turbine 
% 17 -     after heat exchanger

tempisn(1) = PARAMS.BRA_LOW_TEMP;
tempisn(2) = PARAMS.BRA_LOW_TEMP*(PARAMS.BRA_PRESR^((PARAMS.K_AIR-1)/PARAMS.K_AIR));
tempisn(3) = PARAMS.BRA_PEAK_TEMP;
tempisn(4) = PARAMS.BRA_PEAK_TEMP/(PARAMS.BRA_PRESR^((PARAMS.K_AIR-1)/PARAMS.K_AIR));
tempisn(5) = PARAMS.BRA_MID_TEMP;

temp(1) = tempisn(1);
temp(2) = ((tempisn(2)-tempisn(1))/0.75)+tempisn(1);
temp(3) = tempisn(3);
temp(4) = tempisn(3)-0.9*(tempisn(3)-tempisn(4));
temp(5) = tempisn(5);

massflowrate_b = rankine_cycle.cycle.Qin/(PARAMS.CP_AIR*(temp(4)-temp(5)));    

%energy at each stage
energy_b.qin  = PARAMS.CP_AIR*(temp(3)-temp(2));
energy_b.qout = PARAMS.CP_AIR*(temp(4)-temp(5));
energy_b.win  = PARAMS.CP_AIR*(temp(2)-temp(1));
energy_b.wout = PARAMS.CP_AIR*(temp(3)-temp(4));

energy_b.Qin   = energy_b.qin*massflowrate_b;
energy_b.Qout  = energy_b.qout*massflowrate_b;
energy_b.Win   = energy_b.win*massflowrate_b;
energy_b.Wout  = energy_b.wout*massflowrate_b;

%exergy analysis (Kw)
exergy_b(1) = massflowrate_b*((PARAMS.CP_AIR*(temp(1)-(PARAMS.DS_TEMP+273)))-(PARAMS.DS_TEMP+273)*((PARAMS.CP_AIR*log(temp(1)/(PARAMS.DS_TEMP+273))-0.287*log(1000/(PARAMS.DS_PRES*100)))));
exergy_b(2) = massflowrate_b*(PARAMS.CP_AIR*(temp(2)-(PARAMS.DS_TEMP+273))-(PARAMS.DS_TEMP+273)*(PARAMS.CP_AIR*log(temp(2)/(PARAMS.DS_TEMP+273))-0.287*log(16000/(PARAMS.DS_PRES*100))));
exergy_b(3) = massflowrate_b*(PARAMS.CP_AIR*(temp(3)-(PARAMS.DS_TEMP+273))-(PARAMS.DS_TEMP+273)*(PARAMS.CP_AIR*log(temp(3)/(PARAMS.DS_TEMP+273))-0.287*log(16000/(PARAMS.DS_PRES*100))));
exergy_b(4) = massflowrate_b*(PARAMS.CP_AIR*(temp(4)-(PARAMS.DS_TEMP+273))-(PARAMS.DS_TEMP+273)*(PARAMS.CP_AIR*log(temp(4)/(PARAMS.DS_TEMP+273))-0.287*log(1000/(PARAMS.DS_PRES*100))));
exergy_b(5) = massflowrate_b*(PARAMS.CP_AIR*(temp(5)-(PARAMS.DS_TEMP+273))-(PARAMS.DS_TEMP+273)*(PARAMS.CP_AIR*log(temp(5)/(PARAMS.DS_TEMP+273))-0.287*log(1000/(PARAMS.DS_PRES*100))));

%Entropy analysis
ds.comp = PARAMS.CP_AIR*log(temp(2)/temp(1))-0.287*log(PARAMS.BRA_PRESR);
ds.boil = PARAMS.CP_AIR*log(temp(3)/temp(2))-0.287*log(1);
ds.turb = PARAMS.CP_AIR*log(temp(4)/temp(3))-0.287*log(1/PARAMS.BRA_PRESR);
ds.hx = PARAMS.CP_AIR*log(temp(5)/temp(4))-0.287*log(1);

%exergy destroyed
xdest_b.comp = (PARAMS.DS_TEMP+273)*ds.comp;
xdest_b.boil = (PARAMS.DS_TEMP+273)*((ds.boil*massflowrate_b)-(energy_b.Qin/temp(3)));
xdest_b.turb = (PARAMS.DS_TEMP+273)*ds.turb;
xdest_b.hx = (PARAMS.DS_TEMP+273)*((ds.hx*massflowrate_b)+(energy_b.Qout/temp(5)));

%2nd law efficiencies
n.comp = (exergy_b(2)-exergy_b(1))/energy_b.Win;
n.turb = energy_b.Wout/(exergy_b(3)-exergy_b(4));

end
