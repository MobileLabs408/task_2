%==========================================================================
% Author: Carl Larsson
% Description: Extended kalman filter, find H_x
% Date: 2024-04-12

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================
function H_x = get_H_x(x_k_one_plus, p_i, z)

    H_x = [-(p_i(1,1) - x_k_one_plus(1))/z(1,1) , -(p_i(1,2) - x_k_one_plus(2))/z(1,1)  , 0;
           (p_i(1,2) - x_k_one_plus(2))/z(1,1)^2, -(p_i(1,1) - x_k_one_plus(1))/z(1,1)^2, -1;
           -(p_i(2,1) - x_k_one_plus(1))/z(2,1) , -(p_i(2,2) - x_k_one_plus(2))/z(2,1)  , 0;
           (p_i(2,2) - x_k_one_plus(2))/z(2,1)^2, -(p_i(2,1) - x_k_one_plus(1))/z(2,1)^2, -1;
           -(p_i(3,1) - x_k_one_plus(1))/z(3,1) , -(p_i(3,2) - x_k_one_plus(2))/z(3,1)  , 0;
           (p_i(3,2) - x_k_one_plus(2))/z(3,1)^2, -(p_i(3,1) - x_k_one_plus(1))/z(3,1)^2, -1;
           -(p_i(4,1) - x_k_one_plus(1))/z(4,1) , -(p_i(4,2) - x_k_one_plus(2))/z(4,1)  , 0;
           (p_i(4,2) - x_k_one_plus(2))/z(4,1)^2, -(p_i(4,1) - x_k_one_plus(1))/z(4,1)^2, -1;
           -(p_i(5,1) - x_k_one_plus(1))/z(5,1) , -(p_i(5,2) - x_k_one_plus(2))/z(5,1)  , 0;
           (p_i(5,2) - x_k_one_plus(2))/z(5,1)^2, -(p_i(5,1) - x_k_one_plus(1))/z(5,1)^2, -1;
           -(p_i(6,1) - x_k_one_plus(1))/z(6,1) , -(p_i(6,2) - x_k_one_plus(2))/z(6,1)  , 0;
           (p_i(6,2) - x_k_one_plus(2))/z(6,1)^2, -(p_i(6,1) - x_k_one_plus(1))/z(6,1)^2, -1;];

end