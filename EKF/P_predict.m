%==========================================================================
% Author: Carl Larsson
% Description: Extended kalman filter, state covariance prediction update
% Date: 2024-04-12

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================
function P_k_one_plus = P_predict(F_x, F_v, V, P_k)

% Note that ' is used for transpose
P_k_one_plus = F_x * P_k * F_x' + F_v * V * F_v';

end