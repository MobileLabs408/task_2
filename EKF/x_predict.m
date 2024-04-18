%==========================================================================
% Author: Carl Larsson
% Description: Extended kalman filter, state prediction update
% Date: 2024-04-12

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================
function x_k_one_plus = x_predict(x_k, s_r, s_l, l)

    x_temp = [x_k(1) + ((s_r + s_l)/2) * cos(x_k(3));
              x_k(2) + ((s_r + s_l)/2) * sin(x_k(3));
              x_k(3) + (s_r - s_l)/l];

    % Ensure angle is in [-pi,pi]
    x_temp(3) = atan2(sin(x_temp(3)), cos(x_temp(3)));

    x_k_one_plus = x_temp;

end