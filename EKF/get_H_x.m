%==========================================================================
% Author: Carl Larsson
% Description: Extended kalman filter, find H_x
% Date: 2024-04-12

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================
function H_x = get_H_x(x_k_one_plus, p)

    % Two rows for each landmark
    H_x = [-(p(1,1) - x_k_one_plus(1))/sqrt((p(1,2) - x_k_one_plus(2))^2 + (p(1,1) - x_k_one_plus(1))^2)  , -(p(1,2) - x_k_one_plus(2))/sqrt((p(1,2) - x_k_one_plus(2))^2 + (p(1,1) - x_k_one_plus(1))^2)  ,  0;
            (p(1,2) - x_k_one_plus(2))/sqrt((p(1,2) - x_k_one_plus(2))^2 + (p(1,1) - x_k_one_plus(1))^2)^2, -(p(1,1) - x_k_one_plus(1))/sqrt((p(1,2) - x_k_one_plus(2))^2 + (p(1,1) - x_k_one_plus(1))^2)^2, -1;
           -(p(2,1) - x_k_one_plus(1))/sqrt((p(2,2) - x_k_one_plus(2))^2 + (p(2,1) - x_k_one_plus(1))^2)  , -(p(2,2) - x_k_one_plus(2))/sqrt((p(2,2) - x_k_one_plus(2))^2 + (p(2,1) - x_k_one_plus(1))^2)  ,  0;
            (p(2,2) - x_k_one_plus(2))/sqrt((p(2,2) - x_k_one_plus(2))^2 + (p(2,1) - x_k_one_plus(1))^2)^2, -(p(2,1) - x_k_one_plus(1))/sqrt((p(2,2) - x_k_one_plus(2))^2 + (p(2,1) - x_k_one_plus(1))^2)^2, -1;
           -(p(3,1) - x_k_one_plus(1))/sqrt((p(3,2) - x_k_one_plus(2))^2 + (p(3,1) - x_k_one_plus(1))^2)  , -(p(3,2) - x_k_one_plus(2))/sqrt((p(3,2) - x_k_one_plus(2))^2 + (p(3,1) - x_k_one_plus(1))^2)  ,  0;
            (p(3,2) - x_k_one_plus(2))/sqrt((p(3,2) - x_k_one_plus(2))^2 + (p(3,1) - x_k_one_plus(1))^2)^2, -(p(3,1) - x_k_one_plus(1))/sqrt((p(3,2) - x_k_one_plus(2))^2 + (p(3,1) - x_k_one_plus(1))^2)^2, -1;
           -(p(4,1) - x_k_one_plus(1))/sqrt((p(4,2) - x_k_one_plus(2))^2 + (p(4,1) - x_k_one_plus(1))^2)  , -(p(4,2) - x_k_one_plus(2))/sqrt((p(4,2) - x_k_one_plus(2))^2 + (p(4,1) - x_k_one_plus(1))^2)  ,  0;
            (p(4,2) - x_k_one_plus(2))/sqrt((p(4,2) - x_k_one_plus(2))^2 + (p(4,1) - x_k_one_plus(1))^2)^2, -(p(4,1) - x_k_one_plus(1))/sqrt((p(4,2) - x_k_one_plus(2))^2 + (p(4,1) - x_k_one_plus(1))^2)^2, -1;
           -(p(5,1) - x_k_one_plus(1))/sqrt((p(5,2) - x_k_one_plus(2))^2 + (p(5,1) - x_k_one_plus(1))^2)  , -(p(5,2) - x_k_one_plus(2))/sqrt((p(5,2) - x_k_one_plus(2))^2 + (p(5,1) - x_k_one_plus(1))^2)  ,  0;
            (p(5,2) - x_k_one_plus(2))/sqrt((p(5,2) - x_k_one_plus(2))^2 + (p(5,1) - x_k_one_plus(1))^2)^2, -(p(5,1) - x_k_one_plus(1))/sqrt((p(5,2) - x_k_one_plus(2))^2 + (p(5,1) - x_k_one_plus(1))^2)^2, -1;
           -(p(6,1) - x_k_one_plus(1))/sqrt((p(6,2) - x_k_one_plus(2))^2 + (p(6,1) - x_k_one_plus(1))^2)  , -(p(6,2) - x_k_one_plus(2))/sqrt((p(6,2) - x_k_one_plus(2))^2 + (p(6,1) - x_k_one_plus(1))^2)  ,  0;
            (p(6,2) - x_k_one_plus(2))/sqrt((p(6,2) - x_k_one_plus(2))^2 + (p(6,1) - x_k_one_plus(1))^2)^2, -(p(6,1) - x_k_one_plus(1))/sqrt((p(6,2) - x_k_one_plus(2))^2 + (p(6,1) - x_k_one_plus(1))^2)^2, -1];

end