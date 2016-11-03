clc, clear all, close all
%% Combined Gas-Vapor Cycle Analysis
%% Cycle States
a.states(12) = struct('p',[],'t',[],'x',[],'v',[],'h',[],'s',[], 'psi',[]);  % initialize state vectors
s.states(12) = struct('p',[],'t',[],'x',[],'v',[],'h',[],'s',[], 'psi',[]);

[s.states, s.massfrac] = rankine_states_isn(s.states);             % isentropic states
[a.states, a.massfrac] = rankine_states_act(a.states, s.states);   % actual states

%[states] = brayton_states(states);
% Hey Gui, can you write brayton_states.m ?
%
% make sure to take a look at rankine_states.m and continue using the
% states vector for the rest of the states...
%% Energy
energy.rankine = rankine_energy(a.states, a.massfrac)

mass_brayton = brayton_states(energy.rankine)

%energy_b.brayton = brayton_energy(mass_brayton)

%% Destroyed Exergy
[a.states, xdest] = rankine_exergies(a.states, energy.rankine)
% rankine_destroyed_exergy(a.states, energy.rankine)

%% Efficiencies

%% Finances

% Chris, could you add the financial analysis you said you did into here?

%% Piping Network

