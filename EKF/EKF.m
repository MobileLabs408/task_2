%==========================================================================
% Author: Carl Larsson
% Description: Extended kalman filter
% Date: 2024-04-11

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================
%% Clean up
%==========================================================================
close all
clear
clc
%==========================================================================
%% Load data
%==========================================================================
% x, y
landmarks = table2array(readtable('Localisation\Localisation\lab4_dataset_landmarks.csv'));
% t, DeltaSL, DeltaSR
odometry = table2array(readtable('Localisation\Localisation\lab4_dataset_odometry.csv'));
% t, dist 1, angle 1, ..., dist 6, angle 6
sensors = table2array(readtable('Localisation\Localisation\lab4_dataset_sensors.csv'));
% t, x, y, theta
trajectory_original = table2array(readtable('Localisation\Localisation\lab4_dataset_traj.csv'));
%==========================================================================
%% EKF
%==========================================================================

% Parameters
l = 0.1;
sigma_d = 0.5;
sigma_theta = 10*pi/180;
sigma_r = 0.5;
sigma_beta = 10*pi/180;

% Matrices
V = diag([sigma_d, sigma_theta].^2);
W = diag([sigma_r, sigma_beta].^2);

% Initialize matrix which holds reconstructed trajectory
[rows, cols] = size(trajectory_original);
trajectory_reconstructed = zeros(rows,cols);
% First column is time (discrete, k)
trajectory_reconstructed(:, 1) = transpose((0:num_rows-1));

%==========================================================================
%% Plot xy
%==========================================================================

figure
hold on

plot(landmarks(:,1),landmarks(:,2), 'ko', 'MarkerFaceColor', 'k')
plot(trajectory_original(:,2),trajectory_original(:,3),'b')

xlabel("x (m)")
ylabel("y (m)")
xlim([0, 120])
ylim([-250, 150])
legend('Landmarks', 'Original trajectory')
title("Plot of the original and reconstructed trajectory of the robot on the (x, y) plane")

hold off

%==========================================================================
%% Plot with respect to time
%==========================================================================

figure
hold on

% x
subplot(3,1,1)
plot(trajectory_original(:,1), trajectory_original(:,2),'b')
xlabel("t (s)")
ylabel("x (m)")
legend('Original trajectory')

% y
subplot(3,1,2)
plot(trajectory_original(:,1), trajectory_original(:,3),'b')
xlabel("t (s)")
ylabel("y (m)")
legend('Original trajectory')

% theta
subplot(3,1,3)
plot(trajectory_original(:,1), trajectory_original(:,4),'b')
xlabel("t (s)")
ylabel("theta (pi)")
legend('Original trajectory')

sgtitle("Plot of the components of the original and reconstructed trajectory of the robot with respect to time")

hold off

%==========================================================================