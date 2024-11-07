%% Code Written by Hesam Ghanbarzadeh

% This MATLAB Code Applies Wellner's Adaptive Thresholding to Selected Images, Allowing 
% the User to Choose an Image & Converting It to Grayscale if Needed. It Then Uses 
% Bradley's Method for Binarization, Varying Boundary Handling Techniques (Padding Styles 
% & Directions) to Compare Results. The Final Output Shows the Binary Images in Subplots, 
% Demonstrating the Impact of Different Boundary Options on the Thresholding Results.


%% Start Analysis
clc; clear; close all; warning off
%% step 1 : Set Parameters of Figures
set(0,'DefaultFigureWindowStyle','Docked')
set(0, 'DefaultLineLineWidth', 2, 'DefaultLineMarkerSize', 8, 'DefaultAxesLineWidth', 2, 'DefaultAxesFontName', 'Times New Roman', 'DefaultAxesFontSize', 14, 'DefaultAxesFontWeight', 'Bold');
set(groot,'DefaultAxesXGrid','on'); set(groot,'DefaultAxesYGrid','on'); set(groot,'DefaultAxesXminorGrid','on'); set(groot,'DefaultAxesYminorGrid','on')

%% step 2: Convert RGB to GrayScale
% Step 2-1: Define the Images & Prompt User for Selection
Images = {'coins.png', 'cameraman.tif', 'rice.png', 'saturn.png', 'peppers.png', 'printedtext.png'};
fprintf('Select an image:\n1) coins.png\n2) cameraman.tif\n3) rice.png\n4) saturn.png\n5) peppers.png\n6) printedtext.png\n');
Choice = input('Enter the Number of the Image to Display (1 to 6): ');

% step 2-2: Validate User Input
if Choice < 1 || Choice > 6 || ~isnumeric(Choice)
    error('Invalid Selection. Please Enter a Number Between 1 and 6.');
end

% Step 2-3: Load and Display the Original Image
Img = imread(Images{Choice});
figure
imshow(Img)
title('Original Image', 'FontName', 'NewTimesRoman', 'FontSize', 8)

% Step 2-4: Check if the Image Is Colored, Convert to Grayscale if Necessary, and Display
if size(Img, 3) > 1
    GI = rgb2gray(Img);                     % Convert to Grayscale
    % Step 2-5: Display the Grayscale Image
    figure
    imshow(GI);
    title('Grayscale Image', 'FontName', 'Times New Roman', 'FontSize', 8);
else
    GI = Img;
end
GI = im2double(GI);
%% step 3: Binarize Image Based on Wellner Method with Loop for All Combinations
% step 3-1: Define Possible Values for Direction and PadValue
Direction = {'Pr', 'Po', 'Bo'};  
PadValue = {'Rp', 'Sm', 'Cr'};

DirName = {'Pre', 'Post', 'Both'};  
PadName = {'Replicate', 'Symmetric', 'Circular'};

% step 3-2: Determine Number of Subplots Based on Total Combinations
numDirections = numel(Direction);
numPadValues = numel(PadValue);
totalPlots = numDirections * numPadValues;

% step 3-3: Compute Integral Image & Display It
J = IntegralImage(GI);
figure
imshowpair(GI, J, 'Montage')
title('Integral of Image', 'FontName', 'NewTimesRoman', 'FontSize', 10)

% step 3-4: Create a figure to Hold all Subplots and Set size for Better Display
figure('Position', [100, 100, 1500, 900]); % Adjusted figure size

% step 3-5: Loop Through Each Combination of Direction and PadValue
PltIndex = 1;
for d = 1:numDirections
    for p = 1:numPadValues
        % step 3-6: Set Options for the Current Combination
        opts.Direction = Direction{d};
        opts.PadValue = PadValue{p};
        
        % step 3-7: Binarize the Image Using the Bradley Method
        BW = BradleyImage(GI, opts);

        % step 3-8: Create Subplot and Display Binarized Image with Original
        subplot(numDirections, numPadValues, PltIndex);
        imshowpair(GI, BW, 'Montage');
        
        % step 3-9: Title for Each Subplot Showing Current Combination
        title(sprintf('Binary Image - %s & %s', DirName{d}, PadName{p}), 'FontName', 'NewTimesRoman', 'FontSize', 10);
        axis tight; 
        % Step 3-10: Increment Subplot Index
        PltIndex = PltIndex + 1;
    end
end

% Add a main title for the figure
sgtitle('Binary Image Using Wellner Method with Different Directions and PadValues', 'FontSize', 14, 'FontWeight', 'Bold');   % Main title
