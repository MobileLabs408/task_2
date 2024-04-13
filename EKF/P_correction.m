%==========================================================================
% Author: Carl Larsson
% Description: Extended kalman filter, state covariance correction update
% Date: 2024-04-12

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================
function P_k_one = P_correction(P_k_one_plus, K, H_x)

    P_k_one = P_k_one_plus - K * H_x * P_k_one_plus;

end