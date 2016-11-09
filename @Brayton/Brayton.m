classdef Brayton < handle
properties
    states
    mflow  % mass flow rate (kg/s)
    energy
    ds
    xdest
    eff2
end

methods
    function obj = Brayton(rankine)
        obj.states = rankine.states;  % pass in states from rankine cycle
        
        obj.cycle_analysis(rankine)
    end
end


methods (Access = private)
    cycle_analysis(obj, rankine_cycle)
    to_bar_degC(obj) 
end

    
end

