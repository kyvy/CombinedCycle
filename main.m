clc, clear all, close all
addpath('RankineStates/')     % Code for finding rankine cycle states
addpath('RankineComponents/') % Code for rankine cycle component analysis
addpath('Plotting/')          % Code for plotting and plotting tools
%% Combined Gas-Vapor Cycle Analysis

rankine = Rankine();

mass_brayton = brayton_states(rankine)

%energy_b.brayton = brayton_energy(mass_brayton)
% hey Gui. could you write something similar to Rankine() ? eg:
% brayton = Brayton()

%% Finances

% Chris, could you add the financial analysis you said you did into here?

%% Piping Network


%% Plotting

tsdiagram(rankine)