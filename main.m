clc, clear all, close all
%% Combined Gas-Vapor Cycle Analysis
<<<<<<< HEAD
=======
%% Cycle States
a.states(12) = struct('p',[],'t',[],'x',[],'v',[],'h',[],'s',[], 'psi',[]);  % initialize state vectors
s.states(12) = struct('p',[],'t',[],'x',[],'v',[],'h',[],'s',[], 'psi',[]);
>>>>>>> 9ad8c1c32a503930d983acc512f33e68c0bdf95b

rankine = Rankine();

<<<<<<< HEAD
% brayton = Brayton(rankine);
=======
%[states] = brayton_states(states);
% Hey Gui, can you write brayton_states.m ?
%
% make sure to take a look at rankine_states.m and continue using the
% states vector for the rest of the states...
%% Energy
energy.rankine = rankine_energy(a.states, a.massfrac)
>>>>>>> 9ad8c1c32a503930d983acc512f33e68c0bdf95b

mass_brayton = brayton_states(energy.rankine)

%energy_b.brayton = brayton_energy(mass_brayton)

%% Finances

% Chris, could you add the financial analysis you said you did into here?

%% Piping Network

% calculate exergy at each state
