classdef Brayton < handle
properties
    states
    mflow  % mass flow rate
    energy
    
    % overall cycle analysis
    cycle
end

methods
    function obj = Brayton(rankine)
        obj.states = rankine.states;  % pass in states from rankine cycle
        
        obj.states_isn() % find isentropic enthalpies, temps
%         obj.states_act() % find actual enthalpies, temps

        % cycle anlysis
        % find overall xdest, sgen, efficiencies (for the brayton cycle) 
%         obj.cycle_analysis(rankine)

%         % convert states from K and kPa to degC and bar to be consistent with
%         % the rankine cycle states
%         to_bar_degC(obj) 
    end
end


methods (Access = private)
    cycle_analysis(obj, rankine)
    
    states_isn(obj)
    states_act(obj)
    
    to_bar_degC(obj) 
end

methods (Static, Access = private)
    [compressor, turbine] = component_analysis(states)
end

    
end

