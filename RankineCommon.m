classdef RankineCommon < handle
% Functions used by more than one class for analysing the rankine cycle

properties (Constant, Access = protected)
    % make sure the state struct is exactly the same each time we make a new one
    emptystate = @() struct('p',[],'t',[],'x',[],'v',[],'h',[],'s',[],'psi',[],'mfrac',[]);
    newstate = @(p,t,x,v,h,s,psi,mfrac) struct('p',p,'t',t,'x',x,'v',v,'h',h,'s',s,'psi',psi,'mfrac',mfrac);
    
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
    
        state2a = struct('p',p,'t',t,'x',[],'v',v,'h',h,'s',s,'psi',[],'mfrac',[]);
    end
    
    function [state2a] = turbine_actual(state1, state2s)
        % calculate actual state after expansion
        p = state2s.p;
        h = state1.h - PARAMS.ISEN_EFF_TURBINE*(state1.h-state2s.h);
        s = xsteam('s_ph', p, h);
        v = xsteam('v_ph', p, h);
        t = xsteam('T_ph', p, h);

        state2a = struct('p',p,'t',t,'x',[],'v',v,'h',h,'s',s,'psi',[],'mfrac',[]);
    end
    
    function [states] = state_mfracs(states, mfrac)
        y = mfrac.y; z = mfrac.z; % alias for clarity
        
        % calculate mass fraction at each state
        states(1).mfrac  = 1-y-z;
        states(2).mfrac  = 1-y-z; 
        states(3).mfrac  = 1-y; 
        states(4).mfrac  = 1-y; 
        states(5).mfrac  = 1; 
        states(6).mfrac  = 1; 
        states(7).mfrac  = 1; 
        states(8).mfrac  = 1; 
        states(9).mfrac  = 1-y; 
        states(10).mfrac = 1-y-z; 
        states(11).mfrac = z; 
        states(12).mfrac = z; 
    end
end

end

