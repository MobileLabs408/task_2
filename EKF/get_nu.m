%==========================================================================
% Author: Carl Larsson
% Description: Extended kalman filter, find nu (innovation)
% Date: 2024-04-12

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================
function nu = get_nu(x_k_one_plus, p_i, z, omega_r, omega_beta)

    z_vector = reshape(z, 1, [])';

    nu = z_vector - [sqrt((p_i(1,2) - x_k_one_plus(2))^2 + (p_i(1,1) - x_k_one_plus(1))^2) + omega_r;
                     atan2(p_i(1,2) - x_k_one_plus(2), p_i(1,1) - x_k_one_plus(1)) - x_k_one_plus(3) + omega_beta;
                     sqrt((p_i(2,2) - x_k_one_plus(2))^2 + (p_i(2,1) - x_k_one_plus(1))^2) + omega_r;
                     atan2(p_i(2,2) - x_k_one_plus(2), p_i(2,1) - x_k_one_plus(1)) - x_k_one_plus(3) + omega_beta;
                     sqrt((p_i(3,2) - x_k_one_plus(2))^2 + (p_i(3,1) - x_k_one_plus(1))^2) + omega_r;
                     atan2(p_i(3,2) - x_k_one_plus(2), p_i(3,1) - x_k_one_plus(1)) - x_k_one_plus(3) + omega_beta;
                     sqrt((p_i(4,2) - x_k_one_plus(2))^2 + (p_i(4,1) - x_k_one_plus(1))^2) + omega_r;
                     atan2(p_i(4,2) - x_k_one_plus(2), p_i(4,1) - x_k_one_plus(1)) - x_k_one_plus(3) + omega_beta;
                     sqrt((p_i(5,2) - x_k_one_plus(2))^2 + (p_i(5,1) - x_k_one_plus(1))^2) + omega_r;
                     atan2(p_i(5,2) - x_k_one_plus(2), p_i(5,1) - x_k_one_plus(1)) - x_k_one_plus(3) + omega_beta;
                     sqrt((p_i(6,2) - x_k_one_plus(2))^2 + (p_i(6,1) - x_k_one_plus(1))^2) + omega_r;
                     atan2(p_i(6,2) - x_k_one_plus(2), p_i(6,1) - x_k_one_plus(1)) - x_k_one_plus(3) + omega_beta];

end