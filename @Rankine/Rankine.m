classdef Rankine < RankineCommon 
properties
    states
    
    % overall cycle
    cycle
    mfrac
    
    % component analysis
    pump
    turbine
    openFWH   % mixing and open feedwater heater
    procheat  % process heater
    heatx     % heat exchanger (or boiler)
    condenser
end

properties (Access = private)
    bisectp
    bisectm
end

methods
    function obj = Rankine()
        % initialize state vectors
        obj.states.isn(17) = obj.emptystate();
        obj.states.act(17) = obj.emptystate();

        % Initialize bisection classes with allowable error
        obj.bisectp = BisectPressure(1e-6);
        obj.bisectm = BisectMassFraction(1e-6);

        % calculate states
        obj.states_isn();
        obj.states_act();

        % component analysis
        [obj.pump,     ...
         obj.turbine,  ...
         obj.openFWH,  ... 
         obj.procheat, ...
         obj.heatx,    ...
         obj.condenser] = obj.component_analysis(obj.states.act);
        
        obj.cycle_analysis();
    end
end


methods (Access = private)
    states_isn(obj)
    states_act(obj)
    
    cycle_analysis(obj)
end


methods (Static, Access = private)
    [pump, turbine, procheat, openFWH, heatx, condenser] = component_analysis(states)
end
    
end

