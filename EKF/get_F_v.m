%==========================================================================
% Author: Carl Larsson
% Description: Extended kalman filter, find F_v
% Date: 2024-04-12

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================
function F_v = get_F_v(x_k_one_plus)

F_v = [cos(x_k_one_plus(3)), 0;
       sin(x_k_one_plus(3)), 0;
       0,                    1];

end