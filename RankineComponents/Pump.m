classdef Pump
% Given states before and after expansion find:
%   win     - work input
%   win_rev - reversible work input  
%   sgen    - entropy generated
%   xdest   - exergy destroyed
%   eff2    - second law efficiency

properties (Constant)
    work        = @(state1,state2) PARAMS.MASS_FLOW*state1.mfrac*(state2.h-state1.h);
    rev_work    = @(state1,state2) PARAMS.MASS_FLOW*state1.mfrac*(state2.psi-state1.psi);
    entropy_gen = @(state1,state2) PARAMS.MASS_FLOW*state1.mfrac*(state2.s-state1.s);
    exergy_dest = @(state1,state2) PARAMS.MASS_FLOW*state1.mfrac*(state2.h-state1.h+state1.psi-state2.psi);
    efficiency2 = @(state1,state2) (state2.psi-state1.psi)/(state2.h-state1.h);
end

methods (Static)
    function [res] = solve(state1, state2)
        res.win     = Pump.work(state1, state2);
        res.win_rev = Pump.rev_work(state1, state2);
        res.sgen    = Pump.entropy_gen(state1, state2);
        res.xdest   = Pump.exergy_dest(state1, state2);
        res.eff2    = Pump.efficiency2(state1, state2);
    end
end

end

