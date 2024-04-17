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
    % Position noise/uncertainty
    sigma_d = 0.5;
    sigma_theta = 10*pi/180;
    % Sensor noise
    sigma_r = 0.5;
    sigma_beta = 10*pi/180;
    % Initial position uncertainty
    sigma_x = 10;
    sigma_y = 10;
    sigma_theta_0 = pi^2;
    
    % Matrices
    mu = [0,0];
    V = diag([sigma_d, sigma_theta].^2);
    W = diag([sigma_r, sigma_beta].^2);
    % Initial covariance matrix for starting state uncertainty
    P0 = diag([sigma_x, sigma_y, sigma_theta_0]);

    % Initialize matrix which holds reconstructed trajectory
    [rows, cols] = size(trajectory_original);
    % First position (row) is (0,0,0,0) with uncertainty P0
    trajectory_reconstructed = zeros(rows,cols);
    % First column is time (discrete, k)
    trajectory_reconstructed(:, 1) = transpose((0:rows-1));
    
    %----------------------------------------------------------------------
    % Generate trajectory

    % First itteration (starting position) use P0 as covariance of noise
    P_k = P0;
    % Rather than using k and k+1, k-1 and k is used
    for k = 2:rows
        % Use previous x as x_k (x(k)) and new x will be x_k_one (x(k+1))
        x_k = trajectory_reconstructed(k-1, 2:4);
        % u(k)
        s_r = odometry(k-1,3);
        s_l = odometry(k-1,2);

        % Noise
        v = mvnrnd(mu, V, 1);
        % Ensure theta error is in [-pi,pi]
        v(2) = atan2(sin(v(2)), cos(v(2)));
        omega = mvnrnd(mu, W, 1);
        % Ensure beta error is in [-pi,pi]
        omega(2) = atan2(sin(omega(2)), cos(omega(2)));

        % Prediction
        % State
        x_k_one_plus = x_predict(x_k, s_r, s_l, v(1), v(2), l);
        % Uncertainty
        F_x = get_F_x(x_k_one_plus, s_r, s_l);
        F_v = get_F_v(x_k_one_plus);
        P_k_one_plus = P_predict(F_x, F_v, V, P_k);
    
        
        % Correction update
        % Reshape z to match p_i
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
        % All landmark locations
        p_i = landmarks;
        H_x = get_H_x(x_k_one_plus, p_i, z);
        H_omega = get_H_omega();
        K = get_K(P_k_one_plus, H_x, H_omega, W);
        nu = get_nu(x_k_one_plus, p_i, z, omega(1), omega(2));
        % State
        x_k_one = x_correction(x_k_one_plus, K, nu);
        % Uncertainty
        P_k_one = P_correction(P_k_one_plus, K, H_x);

        % Store state and set value for next loop
        trajectory_reconstructed(k, 2:4) = x_k_one';
        P_k = P_k_one;
        

        %{
        trajectory_reconstructed(k, 2:4) = x_k_one_plus';
        P_k = P_k_one_plus;
        %}
    end

    %----------------------------------------------------------------------
    % Return reconstructed trajectory

    trajectory = trajectory_reconstructed;

    %----------------------------------------------------------------------
end