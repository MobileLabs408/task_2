%==========================================================================
% Author: Carl Larsson
% Description: Extended kalman filter, find H_omega
% Date: 2024-04-12

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================
function H_omega = get_H_omega()

    % ???
    H_omega = [1, 0;
               0, 1;
               1, 0;
               0, 1;
               1, 0;
               0, 1;
               1, 0;
               0, 1;
               1, 0;
               0, 1;
               1, 0;
               0, 1];

end