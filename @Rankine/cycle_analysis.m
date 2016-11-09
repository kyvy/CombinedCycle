function [] = cycle_analysis(obj)
% Overall rankine cycle analysis.

% cycle destroyed exergy
obj.cycle.Xdest = sum([ ...
    obj.pump.Xdest,     ...
    obj.turbine.Xdest,  ...
    obj.openFWH.Xdest,  ... 
    obj.procheat.Xdest, ...
    obj.heatx.Xdest,    ...
    obj.condenser.Xdest]);

% cycle generated entropy
obj.cycle.Sgen = sum([ ...
    obj.pump.Sgen,      ...
    obj.turbine.Sgen,   ...
    obj.openFWH.Sgen,   ... 
    obj.procheat.Sgen,  ...
    obj.heatx.Sgen,     ...
    obj.condenser.Sgen]);

% cycle work input
obj.cycle.Win = sum([obj.pump.Win]);
obj.cycle.Win_rev = sum([obj.pump.Win_rev]);

% cycle work output
obj.cycle.Wout = sum([obj.turbine.Wout]);
obj.cycle.Wout_rev = sum([obj.turbine.Wout_rev]);

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

