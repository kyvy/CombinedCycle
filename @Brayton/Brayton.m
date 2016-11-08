classdef Brayton < handle
properties
    states
    
    % component analysis
    compressor
    turbine
    
    % overall cycle analysis
    cycle
end

methods
    function obj = Brayton(states)
        obj.states = states;  % pass in states from rankine cycle
    
        % component analysis
        [obj.compressor, obj.turbine] = obj.component_analysis(obj.states.act);
    end
end


methods (Access = private)
    cycle_analysis(obj)
    states_act(obj)
end

methods (Static, Access = private)
    [compressor, turbine] = component_analysis(states)
end

    
end

