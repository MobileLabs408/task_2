%==========================================================================
% Author: Carl Larsson
% Description: Extended kalman filter, state correction update
% Date: 2024-04-12

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================
function x_k_one = x_correction(x_k_one_plus, K, nu)

x_k_one = x_k_one_plus + K*nu;

end