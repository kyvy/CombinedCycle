classdef PressureBisection < handle
% Given a desired temperature and entropy solve for pressure using the
% bisect method.
    
properties (Access = private)
    goal_temp, allowable_error
    min_pres, max_pres
end

properties
    state
    iters % iterations
end
    
methods
    function obj = PressureBisection(allowable_error)
        % PressureBisection(allowable_error)
        % 
        % allowable_error: 
        %   Allowed percent difference between goal temp and actual temp.
        
        if nargin == 1; obj.allowable_error = allowable_error;
        else obj.allowable_error = 1e-6; 
        end
    end

    function obj = set(obj, state, goal_temp, min_pres, max_pres)
        % set(obj, state, goal_temp, min_pres, max_pres)
        %
        % state: A struct containing p, t, h, s fields.
        % goal_temp: The desired final temperature.
        % min_pres: lower pressure bound.
        % max_pres: upper pressure bound.
        
        assert(~isempty(state.s), 'State must have a known entropy.')

        obj.goal_temp = goal_temp;
        obj.min_pres = min_pres;
        obj.max_pres = max_pres;
        obj.state = state;
        obj.iters = 1;
    end

    function [state] = solve(obj)
        % [state] = solve()
        %
        % state: A struct of p, t, h, s values.
        
        [pres_a, pres_b] = obj.bisection(obj.min_pres, obj.max_pres);
        while obj.error() > obj.allowable_error
            [pres_a, pres_b] = obj.bisection(pres_a, pres_b);
            obj.iters = obj.iters + 1;
        end

        obj.state.h = xsteam('h_ps', obj.state.p, obj.state.s);
        state = obj.state;
    end
end
    
methods (Access = private)
    
    function [pres_a, pres_b] = bisection(obj, pres_a, pres_b)
        obj.state.p = (pres_a + pres_b)/2;
            if     obj.func(obj.state.p) < obj.goal_temp; pres_a = obj.state.p;
            elseif obj.func(obj.state.p) > obj.goal_temp; pres_b = obj.state.p;
            end
    end

    function [temp] = func(obj, pressure)
        temp = xsteam('T_ps', pressure, obj.state.s);
        assert(isfinite(temp), 'State does not exist.')
        obj.state.t = temp;
    end

    function [temp_error] = error(obj)
        temp_error = abs((obj.state.t - obj.goal_temp)/obj.state.t);
    end
end 
end

