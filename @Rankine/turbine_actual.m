function [state2a] = turbine_actual(state1, state2s)
% calculate actual state after expansion
p = state2s.p;
h = state1.h - PARAMS.ISEN_EFF_TURBINE*(state1.h-state2s.h);
s = xsteam('s_ph', p, h);
v = xsteam('v_ph', p, h);
t = xsteam('T_ph', p, h);

state2a = struct('p',p,'t',t,'x',[],'v',v,'h',h,'s',s,'psi',[]);
end