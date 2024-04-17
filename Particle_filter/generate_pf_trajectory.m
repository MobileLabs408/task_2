%==========================================================================
% Author: Carl Larsson
% Description: Generate particle filter trajectory
% Date: 2024-04-17

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================
function [trajectory, final_particles] = generate_pf_trajectory(landmarks, odometry, sensors, trajectory_original, N)
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

    % Initilize particles
    x_0 = x_min + (x_max - x_min) * rand(N, 1);
    y_0 = y_min + (y_max - y_min) * rand(N, 1);
    theta_0 = theta_min + (theta_max - theta_min) * rand(N, 1);
    % Ensure theta in [-pi,pi]
    theta_0 = atan2(sin(theta_0), cos(theta_0));
    particles = [x_0, y_0, theta_0];
    % And particle weights
    w = ones(N,1);
    w = w/N;

    % Initialize matrix which holds reconstructed trajectory (mean of all particles at each time step)
    [rows, cols] = size(trajectory_original);
    trajectory_reconstructed = zeros(rows,cols);
    trajectory_reconstructed(1,2:4) = [mean(particles(:,1)), mean(particles(:,2)), mean(particles(:,3))];
    % First column is time (discrete, k)
    trajectory_reconstructed(:, 1) = transpose((0:rows-1));

    %----------------------------------------------------------------------
    % State estimation

    % Rather than using k and k+1, k-1 and k is used
    for k = 2:rows
        % u(k)
        s_r = odometry(k-1,3);
        s_l = odometry(k-1,2);

        % Prediction
        for i = 1:N
            % Spread
            r_d = unifrnd(a_d, b_d);
            r_theta = random(r_theta_dist);
            % Ensure angle in [-pi,pi]
            r_theta = atan2(sin(r_theta), cos(r_theta));

            % Particle filter prediction update
            particles(i,:) = x_i_predict(particles(i,:), s_r, s_l, r_d, r_theta, l);
        end

        % Correction
        % All landmark locations
        p = landmarks;
        % Reshape z to match p
        % z(k+1) containing sensor readings to all landmarks
        z = [sensors(k,2:3);
             sensors(k,4:5);
             sensors(k,6:7);
             sensors(k,8:9);
             sensors(k,10:11);
             sensors(k,12:13)];
        % Ensure all beta in [-pi,pi]
        [z_rows,~] = size(z);
        for beta = 2:z_rows
            z(beta) = atan2(sin(z(beta)),cos(z(beta)));
        end

        % Innovation and weight update for all particles
        for i = 1:N
            % Noise
            omega_d = random(omega_d_dist);
            omega_beta = random(omega_beta_dist);
            % Ensure angle in [-pi,pi]
            omega_beta = atan2(sin(omega_beta), cos(omega_beta));

            % Innovation
            nu = get_nu_pf(particles(i, :), p, z, omega_d, omega_beta);

            % Covariance like matrix L
            L = find_L();

            % Weight update
            w(i) = weight_update(nu, L);

            % Normalize weights
            w = normalize_weights(w);
        end        

        % Low variance resampling
        particles = low_var_resampling(particles, w, N);

        % Each point in the trajectory is just the mean of all the particles
        trajectory_reconstructed(k,2:4) = [mean(particles(:,1)), mean(particles(:,2)), mean(particles(:,3))];

    end

    %----------------------------------------------------------------------
    % Return reconstructed trajectory and final particle cluster

    trajectory = trajectory_reconstructed;
    final_particles = particles;

    %----------------------------------------------------------------------
end