classdef Brayton < handle
properties
    states
    massFlowRate
    power
    heat
    
    % component analysis
    compressor
    turbine
    
    % overall cycle analysis
    cycle
end

methods
    function obj = Brayton(states)
        obj.states = states;  % pass in states from rankine cycle
        states(13).t = PARAMS.BRA_LOW_TEMP;
        states(14).t = PARAMS.BRA_LOW_TEMP*(PARAMS.BRA_PRESR^((PARAMS.K_AIR-1)/PARAMS.K_AIR));
        states(15).t = PARAMS.BRA_PEAK_TEMP;
        states(16).t = PARAMS.BRA_PEAK_TEMP/(PARAMS.BRA_PRESR^((PARAMS.K_AIR-1)/PARAMS.K_AIR));
        states(17).t = PARAMS.BRA_MID_TEMP;
        massFlowRate = rankine_cycle.total.Qin/(PARAMS.CP_AIR*(states_b(16).t-states_b(17).t));
        
        heat.qin  = PARAMS.CP_AIR*(states(15).t-states(14).t);
        heat.qout = PARAMS.CP_AIR*(states(16).t-states(17).t);
        power.win  = PARAMS.CP_AIR*(states(14).t-states(13).t);
        power.wout = PARAMS.CP_AIR*(states(15).t-states(16).t);

        heat.Qin   = heat.qin*massFlowRate;
        heat.Qout  = heat.qout*massFlowRate;
        power.Win   = power.win*massFlowRate;
        power.Wout = power.wout*massFlowRate;
        
        
        
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

