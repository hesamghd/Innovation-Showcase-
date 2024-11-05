%% Code written by Hesam Ghanbarzadeh

% This MATLAB Code Applies Wellner's Adaptive Thresholding Method on Selected Images.
% The Code Allows the User to Select an Image from a Predefined List & Converts it to Grayscale if Needed.
% It Then Creates Binary Images by Applying the Wellner Method with Different Padding Techniques & Directions,
% Offering Various Options for Handling Image Boundaries.
% 
% The Following Padding Methods Are Applied in All Directions:
% - 'RL', 'LR', 'UD', & 'DU' (for Padding Direction)
% - 'Replicate', 'Symmetric', & 'Circular' (for Padding Style)
%
% Results for Each Combination Are Displayed Using Subplots for Comparison.
%
% The Core Functions Used Are:
% 1. `WellnerImage`: Implements Wellner Thresholding Based on Direction & Padding Style.
% 2. `PadArray`: Manages Padding Based on Direction & Padding Style, Suitable for Grayscale & Color Images.


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
figure(1)
imshow(Img)
title('Original Image', 'FontName', 'NewTimesRoman', 'FontSize', 8)

% Step 2-4: Check if the Image Is Colored, Convert to Grayscale if Necessary, and Display
if size(Img, 3) > 1
    GI = rgb2gray(Img);                     % Convert to Grayscale
    % Step 2-5: Display the Grayscale Image
    figure(2)
    imshow(GI);
    title('Grayscale Image', 'FontName', 'Times New Roman', 'FontSize', 8);
else
    GI = Img;
end
%% step 3: Binarize Image based on Wellner Method
% step 3-1: Define the Possible Values for Method & PadValue
methods = {'RL', 'LR', 'UD', 'DU'};
padValues = {'Rp', 'Sm', 'Cr'};

% step 3-2: Create a Figure for Displaying Results
figure;
set(gcf, 'Position', [100, 100, 1200, 800]);            % Adjust Figure Size

% step 3-3: Initialize Subplot Counter
plotIndex = 1;

% step 3-4: Loop Through Each Method & PadValue Combination
for m = 1:length(methods)
    for p = 1:length(padValues)
        % step 3-4-1: Set Options for Current Combination
        opts.Method = methods{m};
        opts.PadValue = padValues{p};

        % step 3-4-2: Apply WellnerImage Function to Get Binary Image
        BW = WellnerImage(GI, opts);

        % step 3-4-3: Display Result in a Subplot
        subplot(4, 3, plotIndex);
        imshowpair(BW, GI, 'Montage');

        % step 3-4-4: Create Title with Current Settings
        title(sprintf('Method: %s, PadValue: %s', methods{m}, padValues{p}), 'FontName', 'NewTimesRoman', 'FontSize', 8);
        % step 3-4-5: Increment Subplot Index
        plotIndex = plotIndex + 1;
    end
end



