clc, clear all, close all
%% Combined Gas-Vapor Cycle Analysis

rankine = Rankine();

%% Energy

mass_brayton = brayton_states(rankine.energy)

%energy_b.brayton = brayton_energy(mass_brayton)
% hey Gui. could you write something similar to Rankine() ? eg:
% brayton = Brayton()


%% Finances

% Chris, could you add the financial analysis you said you did into here?

%% Piping Network