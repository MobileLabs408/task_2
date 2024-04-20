%==========================================================================
% Author: Carl Larsson
% Description: Particle filter, calculate covariance like matrix L
% Date: 2024-04-17

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================
function L = find_L(s_d,s_beta)

    % Accounts for noise distribution
    L = diag([s_d, s_beta, s_d, s_beta, s_d, s_beta, s_d, s_beta, s_d, s_beta, s_d, s_beta,].^2);

end