classdef Turbine
% Given states before and after expansion find:
%   Wout     - work input
%   Wout_rev - reversible work input  
%   Sgen     - entropy generated
%   Xdest    - exergy destroyed
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
        res.Wout     = Turbine.work(state1, state2, mfrac);
        res.Wout_rev = Turbine.rev_work(state1, state2, mfrac);
        res.Sgen     = Turbine.entropy_gen(state1, state2, mfrac);
        res.Xdest    = Turbine.exergy_dest(state1, state2, mfrac);
        res.eff2     = Turbine.efficiency2(state1, state2);
    end
end
    
end

