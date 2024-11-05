function HIST = ComputeHistogram(I)
% ComputeHistogram Calculates the Histogram of Brightness Levels for a Grayscale Image.

% Step 1: Determine Number of Brightness Levels
L = max(I(:)) + 1; % Number of Brightness Levels
HIST = zeros(1, L); % Initialize Histogram Array
% Step 2: Get Image Size
[Rows, Colms] = size(I);

% Step 3: Count Brightness Level Occurrences
for i = 1:Rows
    for j = 1:Colms
        % Step 4: Get Brightness Level at Pixel (i, j)
        Temp = I(i, j);          
        % Step 5: Increment Histogram Bin
        HIST(Temp + 1) = HIST(Temp + 1) + 1; 
    end
end
end
