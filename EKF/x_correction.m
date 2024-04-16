%==========================================================================
% Author: Carl Larsson
% Description: Extended kalman filter, state correction update
% Date: 2024-04-12

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================
function x_k_one = x_correction(x_k_one_plus, K, nu)

    x_temp = x_k_one_plus + K*nu;

    % Ensure theta between -pi and pi
    x_temp(3) = atan2(sin(x_temp(3)), cos(x_temp(3)));

    x_k_one = x_temp;

end