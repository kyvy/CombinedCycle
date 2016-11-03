classdef PARAMS
% Class for storing constants/parameters 

properties (Constant)
REJECT_TEMP = 30 + 273;   % condenser rejection temp. (K)
PEAK_PRES = 160;          % operating pres. of high-p turbine (bar)
PROC_HEAT_PRES = 6.89476; % process heat pressure (bar)

DS_TEMP = PARAMS.REJECT_TEMP;  % dead state temperature (K)
DS_PRES = 1.01;         % dead state pressure (bar)
DS_ENTROPY = xsteam('s_pT', PARAMS.DS_TEMP, PARAMS.DS_PRES);
DS_ENTHALPY = xsteam('h_pT', PARAMS.DS_TEMP, PARAMS.DS_PRES);

PEAK_TEMP = 550;  % (degC)

MASS_FLOW = 60;             % flow rate through condenser (kg/s)
PROC_HEAT_MASS_FLOW = 31.5; % flow rate of supplied steam (kg/s)

% flow mass fraction through the process heater  
FRAC_Z = PARAMS.PROC_HEAT_MASS_FLOW/PARAMS.MASS_FLOW; 

% isentropic efficencies
ISEN_EFF_PUMP    = 0.75;
ISEN_EFF_TURBINE = 0.90;  % can be 0.80, 0.85, 0.90

% brayton cycle
BRA_PRESR        = 16;       % pressure ratio on brayton cycle. (we can specify pressures later)
BRA_PEAK_TEMP    = 1500;     % peak temp on brayton cycle (K)
BRA_LOW_TEMP     = 300;      % temp before compressor (K)
BRA_MID_TEMP     = 420;      % temp at turine exit (K)
CP_AIR           = 1.005;    % air cp at 300K (Kj/Kg.K)
K_AIR            = 1.4; 

% costs
COST_TURBINE   = turbine_cost(PARAMS.ISEN_EFF_TURBINE);
COST_FWH       = 0.50;  % feedwater heater cost (MIL USD)
OPERATING_COST = 0.75;  % cost of operating plant (MIL USD/year)
COST_POWER     = 0.11;  % cost of electricity (USD/kWh)
COST_NAT_GAS   = 2.50;  % cost of natural gas (MIL USD/BTU)

end
end


function [cost] = turbine_cost(isen_efficiency)
% determine turbine cost (MIL USD) from turbine efficiency

switch isen_efficiency
    case 0.80; cost = 0.50;
    case 0.85; cost = 0.75;
    case 0.90; cost = 1.00;
    otherwise error('Please specify a valid turbine efficiency.')
end
end
