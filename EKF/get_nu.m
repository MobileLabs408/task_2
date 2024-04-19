%==========================================================================
% Author: Carl Larsson
% Description: Extended kalman filter, find nu (innovation)
% Date: 2024-04-12

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================
function nu = get_nu(x_k_one_plus, p, z)

    % Note ' is used for transform
    z_vector = reshape(z', [], 1);

    % Two rows (distance and angle) for each landmark
    nu_temp = z_vector - [ sqrt((p(1,2) - x_k_one_plus(2))^2 + (p(1,1) - x_k_one_plus(1))^2);
                          atan2((p(1,2) - x_k_one_plus(2)),    (p(1,1) - x_k_one_plus(1))) - x_k_one_plus(3);
                           sqrt((p(2,2) - x_k_one_plus(2))^2 + (p(2,1) - x_k_one_plus(1))^2);
                          atan2((p(2,2) - x_k_one_plus(2)),    (p(2,1) - x_k_one_plus(1))) - x_k_one_plus(3);
                           sqrt((p(3,2) - x_k_one_plus(2))^2 + (p(3,1) - x_k_one_plus(1))^2);
                          atan2((p(3,2) - x_k_one_plus(2)),    (p(3,1) - x_k_one_plus(1))) - x_k_one_plus(3);
                           sqrt((p(4,2) - x_k_one_plus(2))^2 + (p(4,1) - x_k_one_plus(1))^2);
                          atan2((p(4,2) - x_k_one_plus(2)),    (p(4,1) - x_k_one_plus(1))) - x_k_one_plus(3);
                           sqrt((p(5,2) - x_k_one_plus(2))^2 + (p(5,1) - x_k_one_plus(1))^2);
                          atan2((p(5,2) - x_k_one_plus(2)),    (p(5,1) - x_k_one_plus(1))) - x_k_one_plus(3);
                           sqrt((p(6,2) - x_k_one_plus(2))^2 + (p(6,1) - x_k_one_plus(1))^2);
                          atan2((p(6,2) - x_k_one_plus(2)),    (p(6,1) - x_k_one_plus(1))) - x_k_one_plus(3)];

    % Ensure angle is in [-pi,pi]
    [rows,~] = size(nu_temp);
    for n = 2:2:rows
        nu_temp(n) = atan2(sin(nu_temp(n)), cos(nu_temp(n)));
    end

    nu = nu_temp;

end