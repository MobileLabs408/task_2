%==========================================================================
% Author: Carl Larsson
% Description: Particle filter (Sequential Monte-Carlo method), main file
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
% (rows correspond to landmark 1, ..., 6)
landmarks = table2array(readtable('..\Localisation\Localisation\lab4_dataset_landmarks.csv'));
% t, s_l, s_r
odometry = table2array(readtable('..\Localisation\Localisation\lab4_dataset_odometry.csv'));
% t, dist 1, angle 1, ..., dist 6, angle 6
sensors = table2array(readtable('..\Localisation\Localisation\lab4_dataset_sensors.csv'));
% t, x, y, theta
trajectory_original = table2array(readtable('..\Localisation\Localisation\lab4_dataset_traj.csv'));
%==========================================================================
%% Particle filter
%==========================================================================

% Number of particles
N = 3000;

tic;
% trajectory_reconstructed: t, x, y, theta
% final_particles: x, y, theta
[trajectory_reconstructed, final_particles] = generate_pf_trajectory(landmarks, odometry, sensors, trajectory_original, N);
execution_time = toc;

%==========================================================================
%% Display execution time
%==========================================================================

disp(['Execution time for ', num2str(N), ' number of particles: ', num2str(execution_time), ' (s)']);

%==========================================================================
%% Plot xy
%==========================================================================

figure
hold on

% Plot trajectories and landmarks
plot(landmarks(:,1),landmarks(:,2), 'ko', 'MarkerFaceColor', 'k')
plot(trajectory_original(:,2),trajectory_original(:,3),'b')
plot(trajectory_reconstructed(:,2),trajectory_reconstructed(:,3),'r')
% Plot final cluster of particles
plot(final_particles(:,1), final_particles(:,2),"+",'MarkerFaceColor', [0.9 0.9 0.9]);

xlabel("x (m)")
ylabel("y (m)")
xlim([0, 120])
ylim([-250, 150])
legend('Landmarks', 'Original trajectory','Reconstructed trajectory', 'Final cluster of particles')
title("Plot of the original and reconstructed trajectory of the robot on the (x, y) plane")

hold off

%==========================================================================
%% Plot with respect to time
%==========================================================================

figure
hold on

% x with respect to time
subplot(3,1,1)
plot(trajectory_original(:,1), trajectory_original(:,2),'b',trajectory_reconstructed(:,1), trajectory_reconstructed(:,2),'r')
xlabel("t (s)")
ylabel("x (m)")
legend('Original trajectory','Reconstructed trajectory')

% y with respect to time
subplot(3,1,2)
plot(trajectory_original(:,1), trajectory_original(:,3),'b',trajectory_reconstructed(:,1), trajectory_reconstructed(:,3),'r')
xlabel("t (s)")
ylabel("y (m)")
legend('Original trajectory','Reconstructed trajectory')

% theta with respect to time
subplot(3,1,3)
% Ensure angle is in [-pi,pi]
plot(trajectory_original(:,1), atan2(sin(trajectory_original(:,4)), cos(trajectory_original(:,4))),'b',trajectory_reconstructed(:,1), trajectory_reconstructed(:,4),'r')
xlabel("t (s)")
ylabel("theta (pi)")
legend('Original trajectory','Reconstructed trajectory')

sgtitle("Plot of the components of the original and reconstructed trajectory of the robot with respect to time")

hold off

%==========================================================================