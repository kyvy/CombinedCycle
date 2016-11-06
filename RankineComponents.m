classdef RankineComponents < handle
properties
    pump
    turbine
    procheat
    openFWH
    heatx
end

properties (Access = private)
    state
end

methods
    function obj = RankineComponents(states)
        Pump(states(1), states(2))

    end
end
    
end

