%==========================================================================
% Author: Carl Larsson
% Description: Extended kalman filter, state prediction update
% Date: 2024-04-12

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================
function x_k_one_plus = x_predict(x_k, s_r, s_l, v_d, v_theta, l)

    x_k_one_plus = [x_k(1) + ((s_r + s_l)/2 + v_d) * cos(x_k(3));
                    x_k(2) + ((s_r + s_l)/2 + v_d) * sin(x_k(3));
                    x_k(3) + (s_r - s_l)/l + v_theta];

    % Ensure theta between -pi and pi
    x_k_one_plus(3) = atan2(sin(x_k_one_plus(3)), cos(x_k_one_plus(3)));


end