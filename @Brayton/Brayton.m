classdef Brayton < handle
properties
    states
    mflow  % mass flow rate (kg/s)
    energy
    dS
    Xdest
    eff2
    Xheat_in  % exergy of heat input
    Xheat_out % exergy of heat output
end

methods
    function obj = Brayton(rankine)
        obj.states = rankine.states;  % pass in states from rankine cycle
        
        obj.cycle_analysis(rankine)
        
        obj.Xheat_in  = ((PARAMS.DS_TEMP + 273)/PARAMS.BRA_PEAK_TEMP)*obj.energy.Qin;
        obj.Xheat_out = ((PARAMS.DS_TEMP + 273)/PARAMS.BRA_MID_TEMP)*obj.energy.Qout;
    end
end


methods (Access = private)
    cycle_analysis(obj, rankine_cycle)
    to_bar_degC(obj) 
end

    
end

