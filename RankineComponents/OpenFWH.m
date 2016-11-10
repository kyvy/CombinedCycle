classdef OpenFWH
% Given states before and after mixing find:
%   Sgen    - entropy generated
%   Xdest   - exergy destroyed

methods (Static)
    function [res] = solve(state1, state2, state3, mfrac1, mfrac2)
        if nargin == 3
            mfrac1 = state1.mfrac;
            mfrac2 = state2.mfrac;
        elseif nargin == 4
            mfrac2 = state2.mfrac;
        end
        
        res.Sgen  = OpenFWH.entropy_gen(state1, state2, state3, mfrac1, mfrac2);
        res.Xdest = OpenFWH.exergy_dest(state1, state2, state3, mfrac1, mfrac2);
    end
    
    function [Sgen] = entropy_gen(state1, state2, state3, mfrac1, mfrac2)
        if nargin == 3
            mfrac1 = state1.mfrac;
            mfrac2 = state2.mfrac;
        elseif nargin == 4
            mfrac2 = state2.mfrac;
        end
        
        Sgen = PARAMS.MASS_FLOW * mfrac1 * (state3.s - state1.s) + ...
               PARAMS.MASS_FLOW * mfrac2 * (state3.s - state2.s);
    end
    
    function [Xdest] = exergy_dest(state1, state2, state3, mfrac1, mfrac2)
        if nargin == 3
            mfrac1 = state1.mfrac;
            mfrac2 = state2.mfrac;
        elseif nargin == 4
            mfrac2 = state2.mfrac;
        end
        
        Xdest = PARAMS.MASS_FLOW * mfrac1 * (state1.psi - state3.psi) + ...
                PARAMS.MASS_FLOW * mfrac2 * (state2.psi - state3.psi);
    end
    
end

end

