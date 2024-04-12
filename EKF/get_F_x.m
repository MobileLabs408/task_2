%==========================================================================
% Author: Carl Larsson
% Description: Extended kalman filter, find F_x
% Date: 2024-04-12

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================
function F_x = get_F_x(x_k_one_plus, s_r, s_l)

F_x = [1, 0, -(s_r + s_l)/2 * sin(x_k_one_plus(3));
       0, 1, (s_r + s_l)/2 * cos(x_k_one_plus(3));
       0, 0, 1];

end