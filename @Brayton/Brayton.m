classdef Brayton < handle
properties
    states
    mflow % mass flow rate
    power
    heat
    
    % component analysis
    compressor
    turbine
    
    % overall cycle analysis
    cycle
end

methods
    function obj = Brayton(rankine)
        obj.states = rankine.states;  % pass in states from rankine cycle
        
        obj.states_isn(rankine)
        
%         % component analysis
%         [obj.compressor, obj.turbine] = obj.component_analysis(obj.states.act);
    end
end


methods (Access = private)
    cycle_analysis(obj)
    states_isn(obj, rankine)
    states_act(obj)
    
    to_bar_degC(obj) % convert from K and kPa to degC and bar
end

methods (Static, Access = private)
    [compressor, turbine] = component_analysis(states)
end

    
end

