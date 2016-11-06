function [] = states_act(obj)
% calculate actual rankine states from isentropic states

for i = [1 3 5 7 9 12]; obj.states.act(i) = obj.states.isn(i); end  % unchanged states

obj.states.act(2) = obj.pump_actual(obj.states.isn(1), obj.states.isn(2));
obj.states.act(4) = obj.pump_actual(obj.states.isn(3), obj.states.isn(4));
obj.states.act(6) = obj.pump_actual(obj.states.isn(5), obj.states.isn(6));

obj.states.act(8)  = obj.turbine_actual(obj.states.isn(7), obj.states.isn(8));
obj.states.act(10) = obj.turbine_actual(obj.states.isn(9), obj.states.isn(10));
obj.states.act(11) = obj.turbine_actual(obj.states.isn(9), obj.states.isn(11));

obj.states.act(10).x = xsteam('x_ph', obj.states.act(10).p, obj.states.act(10).h);

obj.mfrac.act.y = obj.mfy(obj.states.act);
obj.mfrac.act.z = obj.mfz(obj.states.act, obj.mfrac.act.y);

% mass fraction at each state
obj.states.act = obj.state_mfracs(obj.states.act, obj.mfrac.act);

% calculate exergy at each state
for i=1:12; obj.states.act(i).psi = obj.psi(obj.states.act(i)); end

end


























