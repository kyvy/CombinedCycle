function [] = states_act(obj)
% calculate actual rankine states from isentropic states

mfy = @(states) (states(5).h - states(4).h)/(states(8).h - states(4).h);
mfz = @(states, y) (1 - y)*(states(3).h - states(2).h)/(states(12).h - states(2).h);

for i = [1 3 5 7 9 12]; obj.states.act(i) = obj.states.isn(i); end  % unchanged states

obj.states.act(2) = obj.pump_actual(obj.states.isn(1), obj.states.isn(2));
obj.states.act(4) = obj.pump_actual(obj.states.isn(3), obj.states.isn(4));
obj.states.act(6) = obj.pump_actual(obj.states.isn(5), obj.states.isn(6));

obj.states.act(8)  = obj.turbine_actual(obj.states.isn(7), obj.states.isn(8));
obj.states.act(10) = obj.turbine_actual(obj.states.isn(9), obj.states.isn(10));
obj.states.act(11) = obj.turbine_actual(obj.states.isn(9), obj.states.isn(11));

obj.states.act(10).x = xsteam('x_ph', obj.states.act(10).p, obj.states.act(10).h);

obj.mfrac.act.y = mfy(obj.states.act);
obj.mfrac.act.z = mfz(obj.states.act, obj.mfrac.act.y);
end


























