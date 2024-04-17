%==========================================================================
% Author: Carl Larsson
% Description: Performs low variance resampling
% Date: 2024-04-17

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================
function particles_new = low_var_resampling(particles, w, N)

    % Create cumulative "histograms"
    c = cumsum(w);

    % Array of which idx to be resampled (same can be picked multiple times)
    resample_idx = zeros(N, 1);

    % Random number
    r = rand(1);

    temp_idx = 1;
    for i = 1:N
        % Make it "circular"
        u = mod(r + (i - 1) / N, 1);
        % Find which part (cumulative histogram) this random number belongs to
        % Increment until the random number is not larger than the
        % "end/top" of the histogram/part
        while u>c(temp_idx)
            temp_idx = temp_idx + 1;
        end
        resample_idx(i) = temp_idx;
    end

    particles_new = particles(resample_idx, :);

end