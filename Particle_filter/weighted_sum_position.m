%==========================================================================
% Author: Carl Larsson
% Description: Particle filter, calculates weighted sum for position estimation
% Date: 2024-04-17

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================
function x = weighted_sum_position(particles,w,N)

    temp_x = [0,0,0];

    % Weighted sum of position of all particles
    for i = 1:N
        temp_x = temp_x + particles(i,:) * w(i);
    end

    % Ensure angle is in [-pi,pi]
    temp_x(3) = atan2(sin(temp_x(3)), cos(temp_x(3)));

    x = temp_x;

end