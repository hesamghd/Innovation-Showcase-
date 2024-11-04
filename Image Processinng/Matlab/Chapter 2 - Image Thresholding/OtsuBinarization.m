%% Code Written by Hesam Ghanbarzadeh

% This Code is Designed for Image Analysis & Thresholding Using Otsu's Method, a Popular Image Processing Technique. 
% The Process Begins by Setting Figure Display Parameters & Loading the Image. 
% The User Selects an Image from a Predefined Set, Which is Then Displayed. 
% If the Image is in Color, It is Automatically Converted to Grayscale.

% Next, the Histogram of the Grayscale Image is Calculated & Displayed to Show the Distribution of Pixel Intensity Values. 
% Using the Histogram Data, the Probability Density Function (PDF) & Cumulative Distribution Function (CDF) are Computed. 
% These Functions Serve as the Foundation for Thresholding the Image & Calculating Between-Class Variance.

% After Calculating the PDF & CDF, the Code Proceeds to Calculate the Overall Mean Intensity Level in the Image. 
% The Between-Class Variance is Then Calculated & Plotted for Each Possible Threshold. 
% This Step Includes an Interactive Visualization of How Between-Class Variance Changes with Different Threshold Values.

% The Optimal Threshold is Identified as the Level That Maximizes the Between-Class Variance According to Otsu's Method, & This Threshold is Marked on the Plot. 
% Finally, the Image is Binarized Using the Optimal Threshold, & the Resulting Binary Image is Displayed. 
% This Binary Image Can Be Used in Various Image Processing Applications, Such as Object Detection or Segmentation.


%% Start Analysis
clc; clear; close all; warning off

%% Step 1: Set Parameters of Figures
% Set Default Figure Window Style to "Docked" to Organize Multiple Figures in One Window
% Set Line Width, Marker Size, Font Style & Grid Parameters for Figures
set(0,'DefaultFigureWindowStyle','docked')
set(0, 'DefaultLineLineWidth', 2, 'DefaultLineMarkerSize', 10, 'DefaultAxesLineWidth', 2, 'DefaultAxesFontName', 'Times New Roman', 'DefaultAxesFontSize', 10, 'DefaultAxesFontWeight', 'Bold');
set(groot,'defaultAxesXGrid','on'); set(groot,'defaultAxesYGrid','on'); set(groot,'defaultAxesXminorGrid','on'); set(groot,'defaultAxesYminorGrid','on')

%% Step 2: Load & Display the Image
% Step 2-1: Define the Images & Prompt User for Selection
Images = {'coins.png', 'cameraman.tif', 'rice.png', 'saturn.png', 'peppers.png'};
Img = imread(Images{input('Enter the number of the image to display (1 to 5): ')});
% Step 2-2: Display the Original Image
figure(1)
imshow(Img)
title('Original Image', 'FontName', 'NewTimesRoman', 'FontSize', 10)

%% step 3: Convert RGB to GrayScale
% Step 3-1: Check if the Image is Colored & Convert it to Grayscale 
if size(Img, 3) > 1
    GI = rgb2gray(Img); % Convert to Grayscale
else
    GI = Img;
end
% Step 3-2: Display the Grayscale Image
figure(2)
imshow(GI);
title('Grayscale Image', 'FontName', 'Times New Roman', 'FontSize', 10);

%% Step 4: Calculate Image's Histogram
% 4-1: Calculate the Histogram of the Grayscale Image
% 4-2: Number of Brightness Level
L = max(GI(:)) + 1; 
HIST = zeros(1, L);
[Rows, Colms] = size(GI);
for i = 1:Rows
    for j = 1:Colms
        Temp = GI(i, j);
        HIST(Temp + 1) = HIST(Temp + 1) + 1;
    end 
end
% 4-3: Plot the Histogram of the Grayscale Image
figure(3)
bar(HIST)
grid on; grid minor
xlabel('Brightness', 'FontName', 'NewTimesRoman', 'fontsize', 10);
ylabel('Affluence', 'FontName', 'NewTimesRoman', 'fontsize', 10)
legend('Histogram of Image')
title('Histogram of Image', 'FontName', 'NewTimesRoman', 'fontsize', 10)

%% Step 5: Calculate Probability Density Function
% Step 5-1: Calculate Probability Density Function (PDF) by Normalizing the Histogram
PDF = HIST / sum(HIST);
% Step 5-2: Plot the PDF of the Grayscale Image 
figure(4)
plot(PDF, 'linewidth', 2, 'Color', rand(1, 3))
grid on; grid minor
xlim([0 255]);
xlabel('Brightness', 'FontName', 'NewTimesRoman', 'fontsize', 10);
ylabel('PDF', 'FontName', 'NewTimesRoman', 'fontsize', 10)
legend('Probability Distribution Function of Image')
title('Probability Distribution Function of Image', 'FontName', 'NewTimesRoman', 'fontsize', 10)

%% Step 6: Calculate Cumulative Distribution Function
% Step 6-1: Calculate the Cumulative Distribution Function (CDF) Using the PDF
CDF = cumsum(PDF);
% Step 6-2: Plot the CDF with Randomized Color 
figure(5)
plot(CDF, 'linewidth', 2, 'Color', rand(1, 3))
grid on; grid minor
xlim([0 255]);
xlabel('Brightness', 'FontName', 'NewTimesRoman', 'fontsize', 10);
ylabel('CDF', 'FontName', 'NewTimesRoman', 'fontsize', 10)
legend('Cumulative Distribution Function of Image')
title('Cumulative Distribution Function of Image', 'FontName', 'NewTimesRoman', 'fontsize', 10)

%% Step 7: Calculate Total Mean
% step 7-1: Define Threshold Candidates from 0 to L-1 for Each Brightness Level
ThrCandid = double(0:L - 1);
% step 7-2: Compute Total Mean (MuToT) Based on PDF & Threshold Candidates
MuToT = sum(ThrCandid .* PDF);

%% Step 8: Calculate Variance Between Class and Plot on Histogram
% Step 8-1: Initialize Plot for Histogram 
figure(6); clf; 
bar(HIST); 
grid on; grid minor;
xlabel('Brightness', 'FontName', 'NewTimesRoman', 'fontsize', 10);
ylabel('Affluence', 'FontName', 'NewTimesRoman', 'fontsize', 10);
title('Histogram of Image with Between-Class Variance', 'FontName', 'NewTimesRoman', 'fontsize', 10);
hold on; 
% step 8-2: Initialize the Array for Storing Between-Class Variance Values
VarBet = zeros(1, L);
yyaxis right        % Switch to the Right y-axis for Plotting Variance
ylabel('Between-Class Variance', 'FontName', 'NewTimesRoman', 'fontsize', 10);

% step 8-3: Initialize an Animated Line for Dynamic Plotting of Between-Class Variance
h = animatedline('Color', 'r', 'LineWidth', 1.5);
% Step 8-4: Calculate Between-Class Variance for Each Threshold
for t = 1:L
    % Step 8-5: Compute Weights for Background (W0) & Foreground (W1) Classes Based on CDF
    W0 = CDF(t);
    W1 = 1 - W0;
    % Step 8-6: Calculate Mean Values for Each Class Using Cumulative Sums
    Mu0 = sum(ThrCandid(1:t) .* PDF(1:t)) / (W0 + eps);
    Mu1 = sum(ThrCandid(t + 1:end) .* PDF(t + 1:end)) / (W1 + eps);
    % Step 8-7: Calculate Variance Between Classes Using Weights & Mean Values
    VarBet(t) = W0 * (Mu0 - MuToT) ^ 2 + W1 * (Mu1 - MuToT) ^ 2;
    % step 8-8: Add the Current Point to the Animated Line for the Right y-axis
    addpoints(h, t, VarBet(t));
    drawnow; 
end
% Step 8-9: Find the Maximum Variance Value & Corresponding Index (Threshold) for Segmentation
[Tx, Indx] = max(VarBet);
% Step 8-10: Mark the Optimal Threshold Point on the Plot (using right axis)
plot(Indx, Tx, 'xk', 'MarkerSize', 12, 'LineWidth', 2);
% Step 8-11: Annotate the Threshold with Text and Coordinates in a Box
yyaxis right;
ylim([0, max(VarBet) * 1.5]);
text(Indx, Tx * 1.1, sprintf('Threshold\n(%d, %.1f)', Indx, Tx), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', ...
    'FontSize', 10, 'FontWeight', 'bold', 'BackgroundColor', 'white', 'EdgeColor', 'black');
legend('Histogram of Image', 'Between-Class Variance', 'Threshold'); hold off; 

%% Step 9: Binarize Image
% step 9-1: Define the Threshold by Calling ThrCandid Function with the Calculated Index
Thr = ThrCandid(Indx);
% step 9-2: Binarize the Image by Comparing Grayscale Intensity with Threshold
BW = GI >= Thr;
% step 9-3: Display the Binary (Thresholded) Image
figure(7)
imshow(BW);
