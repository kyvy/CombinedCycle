classdef BisectMassFraction < RankineCommon
% Find state three given a desired (actual) mass flow fraction (z) through 
% the process heater  
    
properties (Access = private)
    goal_z, allowable_error
    min_h3, max_h3
    z_actual
end

properties
    states
    iters % iterations
    y, z  % mass fractions
end
    
methods
    function obj = BisectMassFraction(allowable_error)
        if nargin == 1; obj.allowable_error = allowable_error;
        else obj.allowable_error = 1e-6; 
        end
    end

    function obj = set(obj, states, goal_z, min_h3, max_h3)
        assert(~isempty(states(3).p), 'Pressure at state three must be known.')
        assert(~isempty(states(4).p), 'Pressure at state four must be known.')
        for i = [2 5 8 12]
            assert(~isempty(states(i).h), strcat('Enthalpy at state ', num2str(i), ' must be known.'))
        end

        obj.goal_z = goal_z;
        obj.min_h3 = min_h3;
        obj.max_h3 = max_h3;
        obj.states = states;
        obj.iters = 1;
    end

    function [states, massfrac] = solve(obj)
        [h3_a, h3_b] = obj.bisection(obj.min_h3, obj.max_h3);
        while obj.error() > obj.allowable_error
            [h3_a, h3_b] = obj.bisection(h3_a, h3_b);
            obj.iters = obj.iters + 1;
        end
        
        obj.states(3).t = xsteam('T_ph', obj.states(3).p, obj.states(3).h);
        obj.states(3).s = xsteam('s_ph', obj.states(3).p, obj.states(3).h);
        obj.states(4).t = xsteam('T_ph', obj.states(4).p, obj.states(4).h);
        obj.states(4).s = xsteam('s_ph', obj.states(4).p, obj.states(4).h);
        
        states = obj.states;
        massfrac.y = obj.y; 
        massfrac.z = obj.z;
    end
end
    
methods (Access = private)
    
    function [h3_a, h3_b] = bisection(obj, h3_a, h3_b)
        h3_m = (h3_a + h3_b)/2;
            if     obj.func(h3_m) < obj.goal_z; h3_a = h3_m;
            elseif obj.func(h3_m) > obj.goal_z; h3_b = h3_m;
            end
    end
    
    function [z] = func(obj, h3)
        obj.states(3).h = h3;
        obj.states(3).v = xsteam('v_ph', obj.states(3).p, obj.states(3).h);
        obj.states(4).h = obj.pump_enthalpy(obj.states(3), obj.states(4));
        assert(isfinite(obj.states(4).h), 'State does not exist.')
        
        % update isentropic mass flow fractions
        obj.mfy();
        obj.mfz();
        
        % calculate and return actual mass flow fraction z
        z = obj.mfz_actual();
    end
    
    
    
    function [z_error] = error(obj)
        z_error = abs((obj.z_actual - obj.goal_z)/obj.z_actual);
    end
    
    function [y] = mfy(obj)
        y = (obj.states(5).h - obj.states(4).h)/(obj.states(8).h - obj.states(4).h);
        obj.y = y;
    end
    
    function [z] = mfz(obj)
        z = (1 - obj.y)*(obj.states(3).h - obj.states(2).h)/(obj.states(12).h - obj.states(2).h);
        obj.z = z;
    end
    
    function [z] = mfz_actual(obj)
        state2a = obj.pump_actual(obj.states(1), obj.states(2));
        state4a = obj.pump_actual(obj.states(3), obj.states(4));
        state8a = obj.turbine_actual(obj.states(7), obj.states(8));
        
        y = (obj.states(5).h - state4a.h)/(state8a.h - state4a.h);
        z = (1 - y)*(obj.states(3).h - state2a.h)/(obj.states(12).h - state2a.h);
        obj.z_actual = z;
    end
    
end

methods (Static, Access = private)
    function [h] = pump_enthalpy(state1, state2)
        h = state1.h + state1.v*(state2.p*100 - state1.p*100);
    end
end 
end
