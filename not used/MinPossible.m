classdef MinPossible < handle
% Find the maximum possible value for xsteam functions
% 
% xsteam(func, arg1, arg2)
% given arg1 find a maximum arg2 such that xsteam(...) returns Nan
% (and vice-versa)
% 


properties (Access = private)
    prev_min_possible
    allowable_error
    xsteam_func
    arg1, arg2
    done, MIN, MAX
end

properties
    min_possible, iters, error
end


methods
    function obj = MinPossible(allowable_error)
        if nargin == 0; obj.allowable_error = 1e-2;
        else obj.allowable_error = allowable_error; end
        obj.MIN = -1e32; obj.MAX = 500;
    end
    
    function obj = set(obj, xsteam_func, arg1, arg2)
        obj.xsteam_func = xsteam_func;
        obj.min_possible = 1;  % for initial error calculation
        obj.arg1 = arg1;
        obj.arg2 = arg2;
        obj.iters = 1;
    end

    function obj = solve(obj)
        [a, b] = obj.bisection(obj.MIN, obj.MAX);
        while obj.err() > obj.allowable_error
            [a, b] = obj.bisection(a, b);
            obj.iters = obj.iters + 1;
        end
    end
end

methods (Access = private)
    function [a, b] = bisection(obj, a, b)
        obj.prev_min_possible = obj.min_possible;
        obj.min_possible = (a + b)/2;
        
        if strcmp(obj.arg1, 'find'); res = xsteam(obj.xsteam_func, obj.min_possible, obj.arg2);
        else res = xsteam(obj.xsteam_func, obj.arg1, obj.min_possible);
        end
        
        if isnan(res); a = obj.min_possible; % res is Nan          
        else b = obj.min_possible;            % res is a number
        end
    end
    
    function [error] = err(obj)
        error = abs((obj.min_possible - obj.prev_min_possible)/obj.prev_min_possible);
        obj.error = error;
    end

end
end