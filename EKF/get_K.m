%==========================================================================
% Author: Carl Larsson
% Description: Extended kalman filter, find K (Kalman gain)
% Date: 2024-04-12

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================
function K = get_K(P_k_one_plus, H_x, H_omega, W)

    % Note that ' is used for transpose
    % Regularization : the addition of the diagonal small valued matrix helps with numerical stability
    eps = 0; % epsilon (small value)
    K = P_k_one_plus * H_x' * pinv(H_x * P_k_one_plus * H_x' + H_omega * W * H_omega' + diag([eps, eps, eps, eps, eps, eps, eps, eps, eps, eps, eps, eps]));

end