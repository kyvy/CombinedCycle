function [xdest] = rankine_destroyed_exergy(states, energy)
% calculate destroyed exergy in the rankine cycle

exergy_destroyed = @(state1, state2, qin, qout) PARAMS.AMB_TEMP*(state2.s - state1.s + qout/state2.t - qin/state1.t);

xdest.x12 = exergy_destroyed(states(1), states(2), 0, 0);
% xdest.x23 = exergy_destroyed(states(1), states(2), 0, 0); mixing 2 and 12
xdest.x34 = exergy_destroyed(states(3), states(4), 0, 0);
% xdest.x45 = exergy_destroyed(states(1), states(2), 0, 0); mixing 4 and 8
xdest.x56 = exergy_destroyed(states(5), states(6), 0, 0);
xdest.x67 = exergy_destroyed(states(6), states(7), energy.qin67, 0);
xdest.x78 = exergy_destroyed(states(7), states(8), 0, 0);
xdest.x89 = exergy_destroyed(states(8), states(9), energy.qin89, 0);


xdest.x101 = exergy_destroyed(states(10), states(1), 0, energy.qout)

end

