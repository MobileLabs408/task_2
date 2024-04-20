%==========================================================================
% Author: Carl Larsson
% Description: Particle filter, state prediction for particle i
% Date: 2024-04-17

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================
function x_i_k_one = x_i_predict(x_k, s_r, s_l, r_d, r_theta, l)

    x_temp = [x_k(1) + ((s_r + s_l)/2 + r_d)*cos(x_k(3));
              x_k(2) + ((s_r + s_l)/2 + r_d)*sin(x_k(3));
              x_k(3) +  (s_r - s_l)/l + r_theta];

    % Ensure angle is in [-pi,pi]
    x_temp(3) = atan2(sin(x_temp(3)), cos(x_temp(3)));

    x_i_k_one = x_temp;

end