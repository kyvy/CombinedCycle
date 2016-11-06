classdef Pump
% Given states before and after pumping find:
%   win     - work input
%   win_rev - reversible work input  
%   sgen    - entropy generation 
%   xdest   - exergy destroyed
%   eff2    - second law efficiency

properties
    win
    win_rev
    sgen
    xdest
    eff2
end

properties (Constant)
    work        = @(state1,state2) PARAMS.MASS_FLOW*state1.mfrac*(state2.h-state1.h);
    rev_work    = @(state1,state2) PARAMS.MASS_FLOW*state1.mfrac*(state2.psi-state1.psi);
    entropy_gen = @(state1,state2) PARAMS.MASS_FLOW*state1.mfrac*(state2.s-state1.s);
    exergy_dest = @(state1,state2) PARAMS.MASS_FLOW*state1.mfrac*(state2.h-state1.h+state1.psi-state2.psi);
    efficiency2 = @(state1,state2) (state1.psi-state2.psi)/(state2.h-state1.h);
end

methods
    function [res] = pump(obj, state1, state2)
        res.win     = obj.work(state1, state2);
        res.win_rev = obj.rev_work(state1, state2);
        res.sgen    = obj.entropy_gen(state1, state2);
        res.xdest   = obj.exergy_dest(state1, state2);
        res.eff2    = obj.efficiency2(state1, state2);
    end
end
    
end

