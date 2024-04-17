%==========================================================================
% Author: Carl Larsson
% Description: Calculate covariance like matrix L
% Date: 2024-04-17

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================
function L = find_L()

    L = [1, 0, 0, 0, 0;
         0, 1, 0, 0, 0;
         0, 0, 1, 0, 0;
         0, 0, 0, 1, 0;
         0, 0, 0, 0, 1];

end