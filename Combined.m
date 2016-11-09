classdef Combined < handle
% Combined Gas-Vapor Cycle

properties
    Win
    Wout
    Wout_rev
    Wnet
    Qin
    Qout
    eff2
    effth
    utilf
    Xdest
    Sgen
end

properties (Access = private)
    rankine
    brayton
end

methods
    function obj = Combined(rankine, brayton)
        
        % these can be simply summed together 
        labels = {'Win' 'Wout' 'Wout_rev' 'Wnet' 'Qin' 'Qout' 'Xdest' 'Sgen'};
        for label = labels  % for each label in labels
            label = char(label);
            rankine.cycle.(label)
%             obj.(label) = rankine.cycle.(label) + brayton.(label);
        end
        
%         % overall second law efficiency
%         obj.eff2 = obj.Wout/obj.Wout_rev;
% 
%         % thermal efficiency
%         obj.effth = 1 - (rankine.condenser.Qout + brayton.Qout)/obj.Qin;
% 
%         % utilization factor
%         obj.utilf = (obj.Wnet + rankine.procheat.Qout)/obj.Qin;
        
    end
    
    
end
    
end

