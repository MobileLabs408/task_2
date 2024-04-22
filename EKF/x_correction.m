%==========================================================================
% Author: Carl Larsson
% Description: Extended kalman filter, state correction update
% Date: 2024-04-12

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================
function x_k_one = x_correction(x_k_one_plus, K, nu)

    % Calculate product of K and nu
    K_nu = K*nu;

    % Ensure angle is in [-pi,pi]
    K_nu(3) = atan2(sin(K_nu(3)),cos(K_nu(3)));

    % State correction update
    x_temp = x_k_one_plus + K_nu;

    % Ensure angle is in [-pi,pi]
    x_temp(3) = atan2(sin(x_temp(3)), cos(x_temp(3)));

    x_k_one = x_temp;

end