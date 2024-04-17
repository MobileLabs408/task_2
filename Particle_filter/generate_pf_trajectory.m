%==========================================================================
% Author: Carl Larsson
% Description: Generate particle filter trajectory
% Date: 2024-04-17

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================
function trajectory = generate_pf_trajectory(landmarks, odometry, sensors, trajectory_original)
    %----------------------------------------------------------------------
    % Parameters

    l = 0.1;
    % Distance spread
    a_d = -1;
    b_d = 3;
    % Angle spread
    mu_theta = 30*pi/180;
    s_theta = 45*pi/180;
    r_theta_dist = makedist('Logistic', 'mu', mu_theta, 'sigma', s_theta);
    % Sensor noise
    s_d = 1;
    omega_d_dist = makedist('Logistic', 'mu', 0, 'sigma', s_d);
    s_beta = 20*pi/180;
    omega_beta_dist = makedist('Logistic', 'mu', 0, 'sigma', s_beta);

    % Initilization range for particles
    x_min = 0;
    x_max = 120;
    y_min = -250;
    y_max = 150;
    theta_min = -pi;
    theta_max = pi;

    % Matrices


    % Number of particles
    N = 100;
    % Initilize particles
    x_0 = x_min + (x_max - x_min) * rand(N, 1);
    y_0 = y_min + (y_max - y_min) * rand(N, 1);
    theta_0 = theta_min + (theta_max - theta_min) * rand(N, 1);
    particles = [x_0, y_0, theta_0];
    % And their weights
    w = ones(N,1);
    w = w/N;

    % Initialize matrix which holds reconstructed trajectory (mean of all particles at each time step)
    [rows, cols] = size(trajectory_original);
    trajectory_reconstructed = zeros(rows,cols);
    trajectory_reconstructed(1,2:4) = [mean(particles(1)), mean(particles(2)), mean(particles(3))];
    % First column is time (discrete, k)
    trajectory_reconstructed(:, 1) = transpose((0:rows-1));

    %----------------------------------------------------------------------
    %

    % Rather than using k and k+1, k-1 and k is used
    for k = 2:rows
        % u(k)
        s_r = odometry(k-1,3);
        s_l = odometry(k-1,2);

        % Noise
        omega_d = random(omega_d_dist);
        omega_beta = random(omega_beta_dist); 

        % Spread
        r_d = unifrnd(a_d, b_d);
        r_theta = random(r_theta_dist);

        % Particle filter prediction update
        for i = 1:N
            particles(i,:) = x_i_predict(particles(i,:), s_r, s_l, r_d, r_theta, l);
        end

        % Innovation

    end

    %----------------------------------------------------------------------
    % Return reconstructed trajectory

    trajectory = trajectory_reconstructed;

    %----------------------------------------------------------------------
end