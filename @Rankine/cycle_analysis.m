function [] = cycle_analysis(obj)
% Overall rankine cycle analysis.

% cycle destroyed exergy
obj.cycle.xdest = sum([ ...
    obj.pump.xdest,     ...
    obj.turbine.xdest,  ...
    obj.openFWH.xdest,  ... 
    obj.procheat.xdest, ...
    obj.heatx.xdest,    ...
    obj.condenser.xdest]);

% cycle generated entropy
obj.cycle.sgen = sum([ ...
    obj.pump.sgen,      ...
    obj.turbine.sgen,   ...
    obj.openFWH.sgen,   ... 
    obj.procheat.sgen,  ...
    obj.heatx.sgen,     ...
    obj.condenser.sgen]);

% cycle work input
obj.cycle.Win = sum([obj.pump.win]);
obj.cycle.Win_rev = sum([obj.pump.win_rev]);

% cycle work output
obj.cycle.Wout = sum([obj.turbine.wout]);
obj.cycle.Wout_rev = sum([obj.turbine.wout_rev]);

% cycle net work output
obj.cycle.Wnet = obj.cycle.Wout - obj.cycle.Win;

% cycle heat input
obj.cycle.Qin = sum([obj.heatx.Qin]);

% cycle heat output
obj.cycle.Qout = sum([  ...
    obj.condenser.Qout, ... 
    obj.procheat.Qout]);

% overall second law efficiency
obj.cycle.eff2 = obj.cycle.Wout/obj.cycle.Wout_rev;

% thermal efficiency
obj.cycle.effth = 1 - obj.condenser.Qout/obj.cycle.Qin;

% utilization factor
obj.cycle.utilf = (obj.cycle.Wnet + obj.procheat.Qout)/obj.cycle.Qin;


end

