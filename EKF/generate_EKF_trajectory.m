%==========================================================================
% Author: Carl Larsson
% Description: Extended kalman filter, state prediction update
% Date: 2024-04-12

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================
function trajectory = generate_EKF_trajectory(landmarks, odometry, sensors, trajectory_original)
    %----------------------------------------------------------------------
    % Parameters

    l = 0.1;
    mu = [0,0];
    % Position noise/uncertainty
    sigma_d = 0.5;
    sigma_theta = 10*pi/180;
    % Sensor noise
    sigma_r = 0.5;
    sigma_beta = 10*pi/180;
    % Initial position uncertainty
    sigma_x = 0.1;
    sigma_y = 0.1;
    sigma_theta_0 = 2*pi/180;
    
    % Matrices
    V = diag([sigma_d, sigma_theta].^2);
    W = diag([sigma_r, sigma_beta].^2);
    % Initial covariance matrix for state uncertainty
    P0 = diag([sigma_x, sigma_y, sigma_theta_0].^2);
    
    % Initialize matrix which holds reconstructed trajectory
    [rows, cols] = size(trajectory_original);
    % First position (row) is (0,0,0,0) with uncertainty P0
    trajectory_reconstructed = zeros(rows,cols);
    % First column is time (discrete, k)
    trajectory_reconstructed(:, 1) = transpose((0:rows-1));
    
    %----------------------------------------------------------------------
    % Generate trajectory

    P_k = P0;
    for k = 2:rows
        x_k = trajectory_reconstructed(k-1, 2:4);
        s_r = odometry(k,3);
        s_l = odometry(k,2);

        % Noise
        v = mvnrnd(mu, V, 1);
        omega = mvnrnd(mu, W, 1);
    
        % Prediction
        % State
        x_k_one_plus = x_predict(x_k, s_r, s_l, v(1), v(2), l);
        % Uncertainty
        F_x = get_F_x(x_k_one_plus, s_r, s_l);
        F_v = get_F_v(x_k_one_plus);
        P_k_one_plus = P_predict(F_x, F_v, V, P_k);
    
    
        % Correction update
        % State
        % Reshape z to match p_i
        z = [sensors(k,2:3);
             sensors(k,4:5);
             sensors(k,6:7);
             sensors(k,8:9);
             sensors(k,10:11);
             sensors(k,12:13)];
        p_i = landmarks;
        H_x = get_H_x(x_k_one_plus, p_i, z);
        H_omega = get_H_omega();
        K = get_K(P_k_one_plus, H_x, H_omega, W);
        nu = get_nu(x_k_one_plus, p_i, z, omega(1), omega(2));
        x_k_one = x_correction(x_k_one_plus, K, nu);
        % Uncertainty
        P_k_one = P_correction(P_k_one_plus, K, H_x);

        %
        trajectory_reconstructed(k, 2:4) = x_k_one';
        P_k = P_k_one;
    end

    %----------------------------------------------------------------------
    %

    trajectory = trajectory_reconstructed;

    %----------------------------------------------------------------------
end