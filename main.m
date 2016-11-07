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

figure()
hold on

% plot saturation vapor curve
p = [rankine.states.isn(1).p, rankine.states.isn(12).p, rankine.states.isn(5).p, PARAMS.PEAK_PRES];
[s_curve, t_curve] = vapor_curve(p);

% plot pressure lines
pressure_lines(rankine.states.isn, s_curve, t_curve, 'k:')
pressure_lines(rankine.states.act, s_curve, t_curve, 'r--')

% plot states
plot([rankine.states.isn.s], [rankine.states.isn.t], 's')
plot([rankine.states.act.s], [rankine.states.act.t], 'v')