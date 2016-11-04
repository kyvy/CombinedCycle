classdef Rankine < RankineCommon 
properties
    states
    energy
    xdest
    mfrac
end

properties (Access = private)
    bisectp
    bisectm
end

methods
    function obj = Rankine()
        % initialize state vectors
        obj.states.isn(16) = obj.emptystate();
        obj.states.act(16) = obj.emptystate();
        
        % Initialize bisection classes with allowable error
        obj.bisectp = BisectPressure(1e-6);
        obj.bisectm = BisectMassFraction(1e-6);
        
        % calculate states
        obj.states_isn();
        obj.states_act();
        
        obj.energy = obj.energies(obj.states.act, obj.mfrac.act);
        [obj.states.act, obj.xdest] = obj.exergies(obj.states.act, obj.energy, obj.mfrac.act);
    end
end


methods (Access = private)
    states_isn(obj)
    states_act(obj)
    
    efficiencies(obj, states)
end


methods (Static)
    [states, xdest] = exergies(states, energy, mfrac);
    [energy] = energies(states, mfrac)
end
    
end

