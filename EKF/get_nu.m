%==========================================================================
% Author: Carl Larsson
% Description: Extended kalman filter, find nu (innovation)
% Date: 2024-04-12

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================
function nu = get_nu(z, x_k_one_plus, p_i, omega_r, omega_beta)

nu = z - [sqrt((p_i(2) - x_k_one_plus(2))^2 + (p_i(1) - x_k_one_plus(1))^2) + omega_r;
          atan2(p_i(2) - x_k_one_plus(2), p_i(1) - x_k_one_plus(1)) - x_k_one_plus(3) + omega_beta];

end