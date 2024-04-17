%==========================================================================
% Author: Carl Larsson
% Description: Normalize weights
% Date: 2024-04-17

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================
function w_normalized = normalize_weights(w)

    w_normalized = w/sum(w);

end