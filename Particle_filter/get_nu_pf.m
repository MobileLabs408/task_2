%==========================================================================
% Author: Carl Larsson
% Description: Particle filter, calculate innovation for particle i to all landmarks
% Date: 2024-04-17

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================
function nu = get_nu_pf(x_i_k_one, p, z_matrix)

    % z already has its angles wraped
    % Note ' is used for transpose
    z_column_vector = reshape(z_matrix', [], 1);

    % Calculate h function
    h = [ sqrt((p(1,2) - x_i_k_one(2))^2 + (p(1,1) - x_i_k_one(1))^2);
         atan2((p(1,2) - x_i_k_one(2)),    (p(1,1) - x_i_k_one(1))) - x_i_k_one(3);
          sqrt((p(2,2) - x_i_k_one(2))^2 + (p(2,1) - x_i_k_one(1))^2);
         atan2((p(2,2) - x_i_k_one(2)),    (p(2,1) - x_i_k_one(1))) - x_i_k_one(3);
          sqrt((p(3,2) - x_i_k_one(2))^2 + (p(3,1) - x_i_k_one(1))^2);
         atan2((p(3,2) - x_i_k_one(2)),    (p(3,1) - x_i_k_one(1))) - x_i_k_one(3);
          sqrt((p(4,2) - x_i_k_one(2))^2 + (p(4,1) - x_i_k_one(1))^2);
         atan2((p(4,2) - x_i_k_one(2)),    (p(4,1) - x_i_k_one(1))) - x_i_k_one(3);
          sqrt((p(5,2) - x_i_k_one(2))^2 + (p(5,1) - x_i_k_one(1))^2);
         atan2((p(5,2) - x_i_k_one(2)),    (p(5,1) - x_i_k_one(1))) - x_i_k_one(3);
          sqrt((p(6,2) - x_i_k_one(2))^2 + (p(6,1) - x_i_k_one(1))^2);
         atan2((p(6,2) - x_i_k_one(2)),    (p(6,1) - x_i_k_one(1))) - x_i_k_one(3)];

    % Ensure angle is in [-pi,pi]
    [rows,~] = size(h);
    for n = 2:2:rows
        h(n) = atan2(sin(h(n)), cos(h(n)));
    end

    % Calculate nu
    nu_temp = h - z_column_vector;

    % Ensure angle is in [-pi,pi]
    [rows,~] = size(nu_temp);
    for n = 2:2:rows
        nu_temp(n) = atan2(sin(nu_temp(n)), cos(nu_temp(n)));
    end

    nu = nu_temp;

end