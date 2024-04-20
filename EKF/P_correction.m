%==========================================================================
% Author: Carl Larsson
% Description: Extended kalman filter, state covariance correction update
% Date: 2024-04-12

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================
function P_k_one = P_correction(P_k_one_plus, K, H_x)

    % The addition of the diagonal small valued matrix helps with numerical stability
    eps = 0.01; % epsilon (small value)
    P_k_one = P_k_one_plus - K * H_x * P_k_one_plus + diag([eps, eps, eps]);

end