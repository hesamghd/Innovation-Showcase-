%% Code Written by Hesam Ghanbarzadeh

% This MATLAB Script Visualizes Various Continuous & Discrete Signals Commonly Used in Signal Processing.
% It Defines a Set of Continuous Signals, Including Step, Impulse, Rectangular Pulse, Sinusoidal, Exponential,
% Triangular, Sawtooth, & Sinc Functions, Followed by Their Discrete Counterparts.
% The Code Customizes Figure Properties for Clear & Consistent Presentation, Then Plots Each Signal
% in a Unique Color & Organized Layout Using Subplots.
% This Project Helps Understand the Characteristics of Basic Signal Types by Providing a Graphical Representation
% & Easy Comparison Between Continuous & Discrete Forms.

%% Start Analysis
clc; clear; close all; warning off

%% Step 1: Set Parameters of Figures
set(0,'DefaultFigureWindowStyle','Docked')
set(0, 'DefaultLineLineWidth', 2, 'DefaultLineMarkerSize', 8, 'DefaultAxesLineWidth', 2, ...
    'DefaultAxesFontName', 'Times New Roman', 'DefaultAxesFontSize', 14, 'DefaultAxesFontWeight', 'Bold');
set(groot,'DefaultAxesXGrid','on'); set(groot,'DefaultAxesYGrid','on'); ...
set(groot,'DefaultAxesXminorGrid','on'); set(groot,'DefaultAxesYminorGrid','on')

%% Step 2: Define Time Parameters
t = -1:0.001:1; % Continuous Time
n = -10:10;    % Discrete Time

%% Step 3: Define Continuous Signals
% Step 3-1: Continuous Step Signal
U_t = t >= 0;

% Step 3-2: Continuous Impulse Signal (Modeled as Small Pulse)
Delta_t = (t >= -0.01) & (t <= 0.01);
Delta_t = Delta_t * 100;

% Step 3-3: Rectangular Pulse Signal
Pulse_t = (t >= -0.5) & (t <= 0.5);

% Step 3-4: Sinusoidal Signal
F = 5;              
Sin_Wave_t = sin(2 * pi * F * t);

% Step 3-5: Exponential Signal
alpha = -5;
Exp_Wave_t = exp(alpha * t);

% Step 3-6: Triangular Signal
Triangular_Wave_t = sawtooth(2 * pi * F * t, 0.5);

% Step 3-7: Sawtooth Signal
Sawtooth_Wave = sawtooth(2 * pi * F * t);

% Step 3-8: Continuous Sinc Signal
Sinc_Wave_t = sinc(t);

%% Step 4: Define Discrete Signals
% Step 4-1: Discrete Step Signal
U_n = n >= 0;

% Step 4-2: Discrete Impulse Signal (Kronecker Delta)
Delta_n = n == 0;

% Step 4-3: Discrete Rectangular Pulse Signal
Pulse_n = (n >= -5) & (n <= 5); 

% Step 4-4: Discrete Sinusoidal Signal
Sin_Wave_n = sin(2 * pi * F * (n / 10));

% Step 4-5: Discrete Exponential Signal
alpha = -0.05;
Exp_Wave_n = exp(alpha * n);

% Step 4-6: Discrete Triangular Signal
Triangular_Wave_n = sawtooth(2 * pi * F * (n / 10), 0.5);

% Step 4-7: Discrete Sawtooth Signal
Sawtooth_Wave_n = sawtooth(2 * pi * F * (n / 10));

% Step 4-8: Discrete Sinc Signal
Sinc_Wave_n = sinc(n / 10);

%% Step 5: Display Signals
% step 5-1: Continuous Signals
figure;
subplot(4, 4, 1);
plot(t, U_t, 'Color', [0.85, 0.33, 0.10]); 
title('Continuous Step Signal');
xlabel('Time'); ylabel('Amplitude');

subplot(4, 4, 2);
stem(t, Delta_t, 'Color', [0.47, 0.67, 0.19]); 
title('Continuous Impulse Signal');
xlabel('Time'); ylabel('Amplitude');

subplot(4, 4, 3);
plot(t, Pulse_t, 'Color', [0.93, 0.69, 0.13]); 
title('Rectangular Pulse Signal');
xlabel('Time'); ylabel('Amplitude');

subplot(4, 4, 4);
plot(t, Sin_Wave_t, 'Color', [0, 0.45, 0.74]); 
title('Sinusoidal Signal');
xlabel('Time'); ylabel('Amplitude');

subplot(4, 4, 5);
plot(t, Exp_Wave_t, 'Color', [0.49, 0.18, 0.56]); 
title('Exponential Signal');
xlabel('Time'); ylabel('Amplitude');

subplot(4, 4, 6);
plot(t, Triangular_Wave_t, 'Color', [0.30, 0.75, 0.93]); 
title('Continuous Triangular Signal');
xlabel('Time'); ylabel('Amplitude');

subplot(4, 4, 7);
plot(t, Sawtooth_Wave, 'Color', [0.64, 0.08, 0.18]); 
title('Sawtooth Signal');
xlabel('Time'); ylabel('Amplitude');

subplot(4, 4, 8);
plot(t, Sinc_Wave_t, 'Color', [0.60, 0.40, 0.20]); 
title('Continuous Sinc Signal');
xlabel('Time'); ylabel('Amplitude');

% step 5-2: Discrete Signals
subplot(4, 4, 9);
stem(n, U_n, 'LineWidth', 2, 'MarkerSize', 6, 'Color', [0.85, 0.33, 0.10]); 
title('Discrete Step Signal');
xlabel('Samples'); ylabel('Amplitude');

subplot(4, 4, 10);
stem(n, Delta_n, 'LineWidth', 2, 'MarkerSize', 6, 'Color', [0.47, 0.67, 0.19]); 
title('Discrete Impulse Signal');
xlabel('Samples'); ylabel('Amplitude');

subplot(4, 4, 11);
stem(n, Pulse_n, 'LineWidth', 2, 'MarkerSize', 6, 'Color', [0.93, 0.69, 0.13]); 
title('Discrete Rectangular Pulse Signal');
xlabel('Samples'); ylabel('Amplitude');

subplot(4, 4, 12);
stem(n, Sin_Wave_n, 'LineWidth', 2, 'MarkerSize', 6, 'Color', [0, 0.45, 0.74]);
title('Discrete Sinusoidal Signal');
xlabel('Samples'); ylabel('Amplitude');

subplot(4, 4, 13);
stem(n, Exp_Wave_n, 'LineWidth', 2, 'MarkerSize', 6, 'Color', [0.49, 0.18, 0.56]); 
title('Discrete Exponential Signal');
xlabel('Samples'); ylabel('Amplitude');

subplot(4, 4, 14);
stem(n, Triangular_Wave_n, 'LineWidth', 2, 'MarkerSize', 6, 'Color', [0.30, 0.75, 0.93]); 
title('Discrete Triangular Signal');
xlabel('Samples'); ylabel('Amplitude');

subplot(4, 4, 15);
stem(n, Sawtooth_Wave_n, 'LineWidth', 2, 'MarkerSize', 6, 'Color', [0.64, 0.08, 0.18]); 
title('Discrete Sawtooth Signal');
xlabel('Samples'); ylabel('Amplitude');

subplot(4, 4, 16);
stem(n, Sinc_Wave_n, 'LineWidth', 2, 'MarkerSize', 6, 'Color', [0.60, 0.40, 0.20]); 
title('Discrete Sinc Signal');
xlabel('Samples'); ylabel('Amplitude');

% Enhance the display of all plots
sgt = sgtitle('Various Continuous and Discrete Signal Types');
set(sgt, 'FontName', 'Times New Roman', 'FontSize', 18);