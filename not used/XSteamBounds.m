classdef XSteamBounds < handle
%
%
% ---- DONT USE THIS YET -----
%
%
%
%
properties (Access = private)
    find_bound
    prev_bound
    allowable_error
    xsteam_func
    arg1, arg2
    done, MIN, MAX
end

properties
    bound, iters, error, result
end


methods
    function obj = MinPossible(allowable_error)
        if nargin == 0; obj.allowable_error = 1e-2;
        else obj.allowable_error = allowable_error; end
    end
    
    function obj = set(obj, xsteam_func, arg1, arg2, find_bound)
        assert(strcmp(find_bound, 'max') | strcmp(find_bound, 'min'), 'find_bound can either be min or max.')
        if strcmp(find_bound, 'max'); obj.MIN=0; obj.MAX=1e32;
        else obj.MIN=-1e32; obj.MAX=500; end
        
        obj.find_bound = find_bound;
        obj.xsteam_func = xsteam_func;
        obj.bound = 1;  % for initial error calculation
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
        obj.prev_bound = obj.bound;
        obj.bound = (a + b)/2;
        
        if strcmp(obj.arg1, 'find'); obj.result = xsteam(obj.xsteam_func, obj.bound, obj.arg2);
        else obj.result = xsteam(obj.xsteam_func, obj.arg1, obj.bound);
        end
        
        if obj.func(obj.result); 
            a = obj.bound;          
        else
            b = obj.bound;
        end
    end
    
    function [error] = err(obj)
        error = abs((obj.bound - obj.prev_bound)/obj.prev_bound);
        obj.error = error;
    end
    
    function [comp] = func(obj, res)
        % when finding max set a to bound if res is a number
        if strcmp(obj.find_bound, 'max'); 
            comp = ~isnan(res);
            
        % when finding min set a to bound if res is Nan
        else
            comp = isnan(res);
        end
    end
    
end
end