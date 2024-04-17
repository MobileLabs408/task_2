%==========================================================================
% Author: Carl Larsson
% Description: Update particle weights
% Date: 2024-04-17

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================
function w_i = weight_update(nu, L)

    w_0 = 0.001;

    % Note that ' is used for transform
    w_i = exp(-nu' * pinv(L) * nu) + w_0;

end