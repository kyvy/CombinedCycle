classdef RankineCommon < handle
% Functions used by more than one class for analysing the rankine cycle

properties (Constant, Access = protected)
    % make sure the state struct is exactly the same each time we make a new one
    emptystate = @() struct('p',[],'t',[],'x',[],'v',[],'h',[],'s',[],'psi',[]);
    newstate = @(p,t,x,v,h,s,psi) struct('p',p,'t',t,'x',x,'v',v,'h',h,'s',s,'psi',psi);
    
    % calculate mass fractions
    mfy = @(states) (states(5).h - states(4).h)/(states(8).h - states(4).h);
    mfz = @(states, y) (1 - y)*(states(3).h - states(2).h)/(states(12).h - states(2).h);
end

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

