function [] = states_isn(obj)
% find isentropic rankine obj.states.isn

obj.states.isn(1).p = xsteam('psat_T', PARAMS.REJECT_TEMP); % Tsat at 30 degC
obj.states.isn(1).x = 0;
obj.states.isn(1).h = xsteam('h_px', obj.states.isn(1).p, obj.states.isn(1).x);
obj.states.isn(1).s = xsteam('s_ph', obj.states.isn(1).p, obj.states.isn(1).h);
obj.states.isn(1).v = xsteam('v_ph', obj.states.isn(1).p, obj.states.isn(1).h);
obj.states.isn(1).t = xsteam('T_ph', obj.states.isn(1).p, obj.states.isn(1).h);

obj.states.isn(2).p = PARAMS.PROC_HEAT_PRES;
obj.states.isn(2).s = obj.states.isn(1).s;
obj.states.isn(2).h = xsteam('h_ps', obj.states.isn(2).p, obj.states.isn(2).s);
obj.states.isn(2).t = xsteam('T_ps', obj.states.isn(2).p, obj.states.isn(2).s);
obj.states.isn(2).v = xsteam('v_ps', obj.states.isn(2).p, obj.states.isn(2).s);

obj.states.isn(12).p = obj.states.isn(2).p;
obj.states.isn(12).x = 0;
obj.states.isn(12).h = xsteam('h_px', obj.states.isn(12).p, obj.states.isn(12).x);
obj.states.isn(12).s = xsteam('s_ph', obj.states.isn(12).p, obj.states.isn(12).h);
obj.states.isn(12).t = xsteam('T_ph', obj.states.isn(12).p, obj.states.isn(12).h);
obj.states.isn(12).v = xsteam('v_ph', obj.states.isn(12).p, obj.states.isn(12).h);

obj.states.isn(7).p = PARAMS.PEAK_PRES;
obj.states.isn(7).t = PARAMS.PEAK_TEMP;
obj.states.isn(7).h = xsteam('h_pT', obj.states.isn(7).p, obj.states.isn(7).t);
obj.states.isn(7).s = xsteam('s_pT', obj.states.isn(7).p, obj.states.isn(7).t);
obj.states.isn(7).v = xsteam('v_pT', obj.states.isn(7).p, obj.states.isn(7).t);

obj.states.isn(10).p = obj.states.isn(1).p;
obj.states.isn(10).x = 0.90;
obj.states.isn(10).h = xsteam('h_px', obj.states.isn(10).p, obj.states.isn(10).x);
obj.states.isn(10).s = xsteam('s_ph', obj.states.isn(10).p, obj.states.isn(10).h);
obj.states.isn(10).t = xsteam('T_ph', obj.states.isn(10).p, obj.states.isn(10).h);
obj.states.isn(10).v = xsteam('v_ph', obj.states.isn(10).p, obj.states.isn(10).h);

obj.states.isn(11).p = obj.states.isn(2).p;
obj.states.isn(11).s = obj.states.isn(10).s;
obj.states.isn(11).h = xsteam('h_ps', obj.states.isn(11).p, obj.states.isn(11).s);
obj.states.isn(11).t = xsteam('T_ph', obj.states.isn(11).p, obj.states.isn(11).h);
obj.states.isn(11).v = xsteam('v_ph', obj.states.isn(11).p, obj.states.isn(11).h);

obj.states.isn(9).s = obj.states.isn(10).s;
obj.states.isn(9) = obj.bisectp.set(obj.states.isn(9), 550, 3, 30).solve();
obj.states.isn(9).v = xsteam('v_ph', obj.states.isn(9).p, obj.states.isn(9).h);

obj.states.isn(8).p = obj.states.isn(9).p;
obj.states.isn(8).s = obj.states.isn(7).s;
obj.states.isn(8).t = xsteam('T_ps', obj.states.isn(8).p, obj.states.isn(8).s);
obj.states.isn(8).h = xsteam('h_pT', obj.states.isn(8).p, obj.states.isn(8).t);
obj.states.isn(8).v = xsteam('v_ph', obj.states.isn(8).p, obj.states.isn(8).h);

obj.states.isn(5).p = obj.states.isn(9).p;
obj.states.isn(5).x = 0;
obj.states.isn(5).h = xsteam('h_px', obj.states.isn(5).p, obj.states.isn(5).x);
obj.states.isn(5).s = xsteam('s_ph', obj.states.isn(5).p, obj.states.isn(5).h);
obj.states.isn(5).v = xsteam('v_ph', obj.states.isn(5).p, obj.states.isn(5).h);
obj.states.isn(5).t = xsteam('T_ph', obj.states.isn(5).p, obj.states.isn(5).h);

obj.states.isn(6).p = obj.states.isn(7).p;
obj.states.isn(6).s = obj.states.isn(5).s;
obj.states.isn(6).h = xsteam('h_ps', obj.states.isn(6).p, obj.states.isn(6).s);
obj.states.isn(6).t = xsteam('T_ps', obj.states.isn(6).p, obj.states.isn(6).s);
obj.states.isn(6).v = xsteam('v_ps', obj.states.isn(6).p, obj.states.isn(6).s);

obj.states.isn(3).p = obj.states.isn(2).p;
obj.states.isn(4).p = obj.states.isn(9).p;
[obj.states.isn, obj.mfrac.isn] = obj.bisectm.set(obj.states.isn, PARAMS.FRAC_Z, 100, 1000).solve();
obj.states.isn(4).v = xsteam('v_ps', obj.states.isn(4).p, obj.states.isn(4).s);

% mass fraction at each state
obj.states.isn = obj.state_mfracs(obj.states.isn, obj.mfrac.isn);

% calculate exergy at each state
for i=1:12; obj.states.isn(i).psi = obj.psi(obj.states.isn(i)); end
end









