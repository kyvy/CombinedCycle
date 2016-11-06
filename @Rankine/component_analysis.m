function [pump, turbine, openFWH, procheat, heatx, condenser] = component_analysis(states)

pump(1) = Pump.solve(states(1), states(2));
pump(2) = Pump.solve(states(3), states(4));
pump(3) = Pump.solve(states(5), states(6));

turbine(1) = Turbine.solve(states(7), states(8), states(7).mfrac);
turbine(2) = Turbine.solve(states(9), states(10), states(10).mfrac);
turbine(3) = Turbine.solve(states(9), states(11), states(11).mfrac);

openFWH(1) = OpenFWH.solve(states(2), states(12), states(3));
openFWH(2) = OpenFWH.solve(states(8), states(4), states(5), states(8).mfrac-states(9).mfrac);

heatx(1) = HeatX.solve(states(6), states(7), 700); % arbitrary temp for now
heatx(2) = HeatX.solve(states(8), states(9), 700); % reheat

procheat = HeatOut.solve(states(11), states(12), 25); % arbitrary temp for now
condenser = HeatOut.solve(states(10), states(1), 30);

end

