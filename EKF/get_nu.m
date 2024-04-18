%==========================================================================
% Author: Carl Larsson
% Description: Extended kalman filter, find nu (innovation)
% Date: 2024-04-12

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================
function nu = get_nu(x_k_one_plus, p_i, z)

    % Note ' is used for transform
    z_vector = reshape(z, 1, [])';

    nu_temp = z_vector - [sqrt((p_i(1,2) - x_k_one_plus(2))^2 + (p_i(1,1) - x_k_one_plus(1))^2);
                          atan2(p_i(1,2) - x_k_one_plus(2), p_i(1,1) - x_k_one_plus(1)) - x_k_one_plus(3);
                          sqrt((p_i(2,2) - x_k_one_plus(2))^2 + (p_i(2,1) - x_k_one_plus(1))^2);
                          atan2(p_i(2,2) - x_k_one_plus(2), p_i(2,1) - x_k_one_plus(1)) - x_k_one_plus(3);
                          sqrt((p_i(3,2) - x_k_one_plus(2))^2 + (p_i(3,1) - x_k_one_plus(1))^2);
                          atan2(p_i(3,2) - x_k_one_plus(2), p_i(3,1) - x_k_one_plus(1)) - x_k_one_plus(3);
                          sqrt((p_i(4,2) - x_k_one_plus(2))^2 + (p_i(4,1) - x_k_one_plus(1))^2);
                          atan2(p_i(4,2) - x_k_one_plus(2), p_i(4,1) - x_k_one_plus(1)) - x_k_one_plus(3);
                          sqrt((p_i(5,2) - x_k_one_plus(2))^2 + (p_i(5,1) - x_k_one_plus(1))^2);
                          atan2(p_i(5,2) - x_k_one_plus(2), p_i(5,1) - x_k_one_plus(1)) - x_k_one_plus(3);
                          sqrt((p_i(6,2) - x_k_one_plus(2))^2 + (p_i(6,1) - x_k_one_plus(1))^2);
                          atan2(p_i(6,2) - x_k_one_plus(2), p_i(6,1) - x_k_one_plus(1)) - x_k_one_plus(3)];

    % Ensure all angles in [-pi,pi]
    [rows,~] = size(nu_temp);
    for n = 2:2:rows
        nu_temp(n) = atan2(sin(nu_temp(n)), cos(nu_temp(n)));
    end

    nu = nu_temp;

end