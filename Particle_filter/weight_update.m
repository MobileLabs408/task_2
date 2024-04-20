%==========================================================================
% Author: Carl Larsson
% Description: Particle filter, update particle weight for particle i (which nu was calculated for)
% Date: 2024-04-17

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================
function w_i = weight_update(nu, L)

    % Ensure nothing has 0 probability
    % Seems to affect convergance time
    w_0 = 10^(-9);

    % Note that ' is used for transpose
    w_i = exp(-nu' * pinv(L) * nu) + w_0;

end