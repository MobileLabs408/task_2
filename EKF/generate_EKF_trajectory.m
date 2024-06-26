%==========================================================================
% Author: Carl Larsson
% Description: Generate trajectory using extended kalman filter (EKF)
% Date: 2024-04-12

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================
function [trajectory, det_P] = generate_EKF_trajectory(landmarks, odometry, sensors, trajectory_original)
    %----------------------------------------------------------------------
    %% Parameters

    % Distance between wheels
    l = 0.1;
    % Odometry noise/error
    sigma_d = 0.5;
    sigma_theta = 10*pi/180;
    % Sensor noise
    sigma_r = 0.5;
    sigma_beta = 10*pi/180;
    % Initial position uncertainty
    sigma_x = 10;
    sigma_y = 10;
    sigma_theta_0 = pi^2;
    
    % Noise matrices
    V = diag([sigma_d, sigma_theta].^2);
    % One set for each landmark sensor reading
    W = diag([sigma_r, sigma_beta, sigma_r, sigma_beta, sigma_r, sigma_beta, sigma_r, sigma_beta, sigma_r, sigma_beta, sigma_r, sigma_beta].^2);
    % Initial covariance matrix for starting state uncertainty
    P_0 = diag([sigma_x, sigma_y, sigma_theta_0]);

    [itterations, cols] = size(trajectory_original);
    % Initialize matrix which holds reconstructed trajectory
    % First position (row) is (0,0,0) with uncertainty P_0 (at time k = 0)
    trajectory_reconstructed = zeros(itterations,cols);
    % First column is time (discrete, k)
    % t, x, y, theta
    trajectory_reconstructed(:, 1) = transpose((0:itterations-1));

    % Store determinant of uncertainy of state
    temp_det_P = zeros(itterations,2);
    temp_det_P(:,1) = transpose((0:itterations-1));
    
    %----------------------------------------------------------------------
    %% Generate trajectory

    % First itteration (starting position) use P_0 as covariance matrix of state uncertainty
    P_k = P_0;
    temp_det_P(1,2) = sqrt(abs(det(P_0)));
    % Rather than using k and k+1, k-1 and k is used
    for k = 2:itterations
        % Use previous x as x_k (x(k-1)) and new x will be x_k_one (x(k))
        % Note that ' is used for transpose
        x_k = trajectory_reconstructed(k-1, 2:4)';
        % u(k-1)
        s_r = odometry(k-1,3);
        s_l = odometry(k-1,2);

        % Prediction
        % State
        x_k_one_plus = x_predict(x_k, s_r, s_l, l);
        % Jacobians
        F_x = get_F_x(x_k, s_r, s_l);
        F_v = get_F_v(x_k);
        % Uncertainty
        P_k_one_plus = P_predict(P_k, F_x, F_v, V);

        % Correction update
        % All landmark locations
        % Rows are landmarks 1,...,6
        % Columns are x and y
        p = landmarks;
        % Reshape z to match p
        % z(k) containing sensor readings to all landmarks
        % Rows are landmarks 1,...,6
        % Columns are r and beta
        z = [sensors(k,2:3);
             sensors(k,4:5);
             sensors(k,6:7);
             sensors(k,8:9);
             sensors(k,10:11);
             sensors(k,12:13)];
        % Ensure angle is in [-pi,pi]
        [z_rows,~] = size(z);
        for row = 1:z_rows
            z(row,2) = atan2(sin(z(row,2)),cos(z(row,2)));
        end
        % Jacobians
        H_x = get_H_x(x_k_one_plus, p);
        H_omega = get_H_omega();
        % Kalman gain
        K = get_K(P_k_one_plus, H_x, H_omega, W);
        % Innovation
        nu = get_nu(x_k_one_plus, p, z);
        % State
        x_k_one = x_correction(x_k_one_plus, K, nu);
        % Uncertainty
        P_k_one = P_correction(P_k_one_plus, K, H_x);

        % Store state
        % Note that ' is used for transpose
        trajectory_reconstructed(k, 2:4) = x_k_one';
        % Store uncertainty
        temp_det_P(k,2) = sqrt(abs(det(P_k_one)));
        % Set value for next loop
        P_k = P_k_one;
    end

    %----------------------------------------------------------------------
    %% Return reconstructed trajectory

    trajectory = trajectory_reconstructed;
    det_P = temp_det_P;

    %----------------------------------------------------------------------
end