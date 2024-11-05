function HIST = ComputeHistogram(I)
% ComputeHistogram Calculates the Histogram of Brightness Levels for a Grayscale
% or Color Image. If the Image Is Grayscale, It Calculates a Single Histogram.
% For Color Images, It Computes a Histogram for Each Color Channel.

% step 1: Check If Image Is Grayscale or Color
if ndims(I) == 2
    % Step 1-2: Grayscale Image
    L = max(I(:)) + 1; % Number of Brightness Levels
    HIST = zeros(1, L); % Initialize Histogram Array
    % step 1-3: Get Image Size
    [Rows, Colms] = size(I);
    % step 1-4: Count Brightness Levels for Grayscale
    for i = 1:Rows
        for j = 1:Colms
            Temp = I(i, j);                                                 % Brightness Level at Pixel (i, j)
            HIST(Temp + 1) = HIST(Temp + 1) + 1;                            % Increment Histogram Bin
        end
    end
else
    % step 1-5: Color Image
    HIST = cell(1, 3);                                                      % Initialize Histogram for Three Channels (R, G, B)
    for ch = 1:3
        % step 1-6: Process Each Color Channel
        channelData = I(:, :, ch);
        L = max(channelData(:)) + 1;                                        % Number of Brightness Levels for Channel
        HIST{ch} = zeros(1, L);                                             % Initialize Histogram Array for Channel
        % step 1-7: Get Channel Size
        [Rows, Colms] = size(channelData);
        % step 1-8: Count Brightness Levels for Channel
        for i = 1:Rows
            for j = 1:Colms
                Temp = channelData(i, j);                                   % Brightness Level at Pixel (i, j)
                HIST{ch}(Temp + 1) = HIST{ch}(Temp + 1) + 1;                % Increment Histogram Bin
            end
        end
    end
end
end
