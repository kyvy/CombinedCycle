function [states, massfrac] = rankine_states_isn(states)
% find isentropic rankine states

bisectp = PressureBisection(1e-6);      % Initialize with allowable error
bisectm = MassFractionBisection(1e-6);  % Initialize with allowable error

pump_enthalpy = @(state1, state2) state1.h + state1.v*(state2.p*100 - state1.p*100);


states(1).p = xsteam('psat_T', 30); % Tsat at 30 degC
states(1).x = 0;
states(1).h = xsteam('h_px', states(1).p, states(1).x);
states(1).s = xsteam('s_ph', states(1).p, states(1).h);
states(1).v = xsteam('v_ph', states(1).p, states(1).h);
states(1).t = xsteam('T_ph', states(1).p, states(1).h);

states(2).p = PARAMS.PROC_HEAT_PRES;  
states(2).h = pump_enthalpy(states(1), states(2));
states(2).s = xsteam('s_ph', states(2).p, states(2).h);
states(2).t = xsteam('T_ph', states(2).p, states(2).h);

states(12).p = states(2).p;
states(12).x = 0;
states(12).h = xsteam('h_px', states(12).p, states(12).x);
states(12).s = xsteam('s_ph', states(12).p, states(12).h);
states(12).t = xsteam('T_ph', states(12).p, states(12).h);

states(7).p = PARAMS.PEAK_PRES;
states(7).t = PARAMS.PEAK_TEMP;
states(7).h = xsteam('h_pT', states(7).p, states(7).t);
states(7).s = xsteam('s_pT', states(7).p, states(7).t);

states(10).p = states(1).p;
states(10).x = 0.90;
states(10).h = xsteam('h_px', states(10).p, states(10).x);
states(10).s = xsteam('s_ph', states(10).p, states(10).h);
states(10).t = xsteam('T_ph', states(10).p, states(10).h);

states(11).p = states(2).p;
states(11).s = states(10).s;
states(11).h = xsteam('h_ps', states(11).p, states(11).s);
states(11).t = xsteam('T_ph', states(11).p, states(11).h);

states(9).s = states(10).s;
states(9) = bisectp.set(states(9), 550, 3, 30).solve();

states(8).p = states(9).p;
states(8).s = states(7).s;
states(8).t = xsteam('T_ps', states(8).p, states(8).s);
states(8).h = xsteam('h_pT', states(8).p, states(8).t);

states(5).p = states(9).p;
states(5).x = 0;
states(5).h = xsteam('h_px', states(5).p, states(5).x);
states(5).s = xsteam('s_ph', states(5).p, states(5).h);
states(5).v = xsteam('v_ph', states(5).p, states(5).h);
states(5).t = xsteam('T_ph', states(5).p, states(5).h);

states(6).p = states(7).p;
states(6).h = pump_enthalpy(states(5), states(6));
states(6).s = xsteam('s_ph', states(6).p, states(6).h);
states(6).t = xsteam('T_ph', states(6).p, states(6).h);

states(3).p = states(2).p;
states(4).p = states(9).p;
[states, massfrac] = bisectm.set(states, PARAMS.FRAC_Z, 100, 1000).solve();


end









