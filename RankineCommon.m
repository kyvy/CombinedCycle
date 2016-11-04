classdef RankineCommon < handle
% Functions used by more than one class for analysing the rankine cycle

methods (Static, Access = protected)
    
    function [state2a] = pump_actual(state1, state2s)
        % calculate actual state after pumping
        p = state2s.p;
        h = (state2s.h - state1.h)/PARAMS.ISEN_EFF_PUMP + state1.h;
        s = xsteam('s_ph', p, h);
        v = xsteam('v_ph', p, h);
        t = xsteam('T_ph', p, h);

        state2a = struct('p',p,'t',t,'x',[],'v',v,'h',h,'s',s,'psi',[]);
    end
    
    function [state2a] = turbine_actual(state1, state2s)
        % calculate actual state after expansion
        p = state2s.p;
        h = state1.h - PARAMS.ISEN_EFF_TURBINE*(state1.h-state2s.h);
        s = xsteam('s_ph', p, h);
        v = xsteam('v_ph', p, h);
        t = xsteam('T_ph', p, h);

        state2a = struct('p',p,'t',t,'x',[],'v',v,'h',h,'s',s,'psi',[]);
    end
    
end

end

