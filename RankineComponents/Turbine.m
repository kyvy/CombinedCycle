classdef Turbine
% Given states before and after expansion find:
%   wout     - work input
%   wout_rev - reversible work input  
%   sgen     - entropy generated
%   xdest    - exergy destroyed
%   eff2     - second law efficiency

properties (Constant)
    work        = @(state1,state2,mfrac) PARAMS.MASS_FLOW*mfrac*(state1.h-state2.h);
    rev_work    = @(state1,state2,mfrac) PARAMS.MASS_FLOW*mfrac*(state1.psi-state2.psi);
    entropy_gen = @(state1,state2,mfrac) PARAMS.MASS_FLOW*mfrac*(state2.s-state1.s);
    exergy_dest = @(state1,state2,mfrac) PARAMS.MASS_FLOW*mfrac*(state2.h-state1.h+state1.psi-state2.psi);
    efficiency2 = @(state1,state2) (state1.h-state2.h)/(state1.psi-state2.psi);
end

methods (Static)
    function [res] = solve(state1, state2, mfrac)
        res.wout     = Turbine.work(state1, state2, mfrac);
        res.wout_rev = Turbine.rev_work(state1, state2, mfrac);
        res.sgen     = Turbine.entropy_gen(state1, state2, mfrac);
        res.xdest    = Turbine.exergy_dest(state1, state2, mfrac);
        res.eff2     = Turbine.efficiency2(state1, state2);
    end
end
    
end

