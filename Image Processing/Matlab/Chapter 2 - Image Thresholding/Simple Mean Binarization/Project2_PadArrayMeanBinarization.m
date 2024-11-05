%% Code written by Hesam Ghanbarzadeh

%% Start Analysis
clc; clear; close all; warning off
%% step 1 : Set Parameters of Figures
set(0,'DefaultFigureWindowStyle','docked')
set(0, 'DefaultLineLineWidth', 2, 'DefaultLineMarkerSize', 8, 'DefaultAxesLineWidth', 2, 'DefaultAxesFontName', 'Times New Roman', 'DefaultAxesFontSize', 14, 'DefaultAxesFontWeight', 'Bold');
set(groot,'defaultAxesXGrid','on'); set(groot,'defaultAxesYGrid','on'); set(groot,'defaultAxesXminorGrid','on'); set(groot,'defaultAxesYminorGrid','on')
%% step 2: Read GrayScale Image
GI = imread('cameraman.tif');
figure(1)
imshow(GI)
title('GrayScale Image', 'FontName', 'NewTimesRoman', 'fontsize', 8)
%% step 3: Padd Array - Pre
% step 3-1: Padd Aray based on Pre & Replicate Method
Nr = 100; Nc = 100; Dir = 'Pre';
J1 =  PadArray(GI, [Nr Nc], Dir, 'Replicate');
% step 3-2: Binary Image based on Mean
Mu1 = ImageMean(J1, Nr, Nc, Dir);
BW1 = GI >= Mu1;
% step 3-3: Display the Result
figure(2)
subplot(3, 3, 1)
imshow(BW1)
title('Binary Image - Padd Array - Pre - Replicate', 'FontName', 'NewTimesRoman', 'fontsize', 8)
% step 3-4: Padd Aray based on Pre & Symmetric Method
J2 =  PadArray(GI, [Nr Nc], Dir, 'Symmetric');
% step 3-5: Binary Image based on Mean
Mu2 = ImageMean(J2, Nr, Nc, Dir);
BW2 = GI >= Mu2;
% step 5-6: Display the Result
subplot(3, 3, 2)
imshow(BW2)
title('Binary Image - Padd Array - Pre - Symmetric', 'FontName', 'NewTimesRoman', 'fontsize', 8)
% step 3-7: Padd Aray based on Pre & Circular Method
J3 =  PadArray(GI, [Nr Nc], Dir, 'Circular');
% step 3-8: Binary Image based on Mean
Mu3 = ImageMean(J3, Nr, Nc, Dir);
BW3 = GI >= Mu3;
% step 3-9: Display the Result
subplot(3, 3, 3)
imshow(BW3)
title('Binary Image - Padd Array - Pre - Circular', 'FontName', 'NewTimesRoman', 'fontsize', 8)
%% step 4: Padd Array - Post
% step 4-1: Padd Aray based on Post & Replicate Method
Nr = 100; Nc = 100; Dir = 'Post';
J4 =  PadArray(GI, [Nr Nc], Dir, 'Replicate');
% step 4-2: Binary Image based on Mean
Mu4 = ImageMean(J4, Nr, Nc, Dir);
BW4 = GI >= Mu4;
% step 4-3: Display the Result
subplot(3, 3, 4)
imshow(BW4)
title('Binary Image - Padd Array - Post - Replicate', 'FontName', 'NewTimesRoman', 'fontsize', 8)
% step 4-4: Padd Aray based on Post & Circular Method
J5 =  PadArray(GI, [Nr Nc], Dir, 'Symmetric');
% step 4-5: Binary Image based on Mean
Mu5 = ImageMean(J5, Nr, Nc, Dir);
BW5 = GI >= Mu5;
% step 5-6: Display the Result
subplot(3, 3, 5)
imshow(BW5)
title('Binary Image - Padd Array - Post - Symmetric', 'FontName', 'NewTimesRoman', 'fontsize', 8)
% step 4-7: Padd Aray based on Post & Circular Method
J6 =  PadArray(GI, [Nr Nc], Dir, 'Circular');
% step 4-8: Binary Image based on Mean
Mu6 = ImageMean(J6, Nr, Nc, Dir);
BW6 = GI >= Mu6;
% step 4-9: Display the Result
subplot(3, 3, 6)
imshow(BW6)
title('Binary Image - Padd Array - Post - Circular', 'FontName', 'NewTimesRoman', 'fontsize', 8)
%% step 5: Padd Array - Both
% step 5-1: Padd Aray based on Both & Replicate Method
Nr = 100; Nc = 100; Dir = 'Both';
J7 =  PadArray(GI, [Nr Nc], Dir, 'Replicate');
% step 5-2: Binary Image based on Mean
Mu7 = ImageMean(J7, Nr, Nc, Dir);
BW7 = GI >= Mu7;
% step 5-3: Display the Result
subplot(3, 3, 7)
imshow(BW4)
title('Binary Image - Padd Array - Both', 'FontName', 'NewTimesRoman', 'fontsize', 8)
% step 5-4: Padd Aray based on Both & Symmetric Method
J8 = PadArray(GI, [Nr Nc], Dir, 'Symmetric');
% step 5-5: Binary Image based on Mean
Mu8 = ImageMean(J8, Nr, Nc, Dir);
BW8 = GI >= Mu8;
% step 5-6: Display the Result
subplot(3, 3, 8)
imshow(BW8)
title('Binary Image - Padd Array - Both - Symmetric', 'FontName', 'NewTimesRoman', 'fontsize', 8)
% step 5-7: Padd Aray based on Both & Symmetric Method
J9 = PadArray(GI, [Nr Nc], Dir, 'Circular');
% step 5-8: Binary Image based on Mean
Mu9 = ImageMean(J9, Nr, Nc, Dir);
BW9 = GI >= Mu9;
% step 5-9: Display the Result
subplot(3, 3, 9)
imshow(BW9)
title('Binary Image - Padd Array - Both - Circular', 'FontName', 'NewTimesRoman', 'fontsize', 8)
