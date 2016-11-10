classdef Combined < handle
% Combined Gas-Vapor Cycle

properties
    Win
    Wout
    Wnet
    Qin
    Qout
    Xdest
    Xheat
    
    eff2
    effth
    utilf
end

properties (Access = private)
    rankine
    brayton
end

methods
    function obj = Combined(rankine, brayton)
        
        % these can simply be summed together 
        labels = {'Win' 'Wout' 'Qin' 'Qout'};
        for label = labels  % for each label in labels
            label = char(label);
            obj.(label) = rankine.cycle.(label) + brayton.energy.(label);
        end
        obj.Wnet = obj.Wout - obj.Win;
        obj.Xdest = rankine.cycle.Xdest + sum([brayton.Xdest.comp, brayton.Xdest.boil, brayton.Xdest.turb, brayton.Xdest.hx]); % total Xdest
        
        % overall second law efficiency
        % Xrecovered/Xexpended | 1 - Xdest/Xexp
        obj.eff2 = sum([obj.Wout, rankine.procheat.Xheat]) /...
                   sum([obj.Win, brayton.Xheat_in]);

        % thermal efficiency
        obj.effth = 1 - (rankine.condenser.Qout + brayton.energy.Qout)/obj.Qin;

        % utilization factor
        obj.utilf = (obj.Wnet + rankine.procheat.Qout)/brayton.energy.Qin
    end
    
    
end
    
end

