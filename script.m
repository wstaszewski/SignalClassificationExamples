% Signal parameters
fs = 1000;                  % Sampling frequency (Hz)
t = 0:1/fs:10;              % Time vector (10 seconds)
f_sine = 0.5;               % Lower frequency for sine wave (Hz) - slower oscillations
A_sine = 1;                 % Amplitude of sine wave
sigma_noise = 0.2;          % Standard deviation for noise
modulation_frequency = 0.5; % Frequency of modulation for cyclostationary behavior (cycles per second)
modulation_depth = 2;       % Depth of modulation (larger value = more pronounced cycles)

% Set figure resolution, parameters and file save settings
res_x = 1920/2; % Resolution in X (pixels)
res_y = 1080/2; % Resolution in Y (pixels)
dpi = 300;    % Dots per inch (DPI) for saving figure
axisFontSize = 16;
labelFontSize = 18;

% Stationary and Deterministic: Sine wave (lower frequency)
figure('Position', [100, 100, res_x, res_y]); 
x_sine = A_sine * sin(2 * pi * f_sine * t);
plot(t, x_sine, 'LineWidth', 1.5);
title('Stationary and Deterministic: Sine wave', 'FontSize', labelFontSize);
xlabel('Time (s)', 'FontSize', axisFontSize);
ylabel('Amplitude', 'FontSize', axisFontSize);
grid on;
saveas(gcf, '_Stationary_Deterministic_Sine_wave.png', 'png');
close;

% Stationary and Non-Deterministic: Stationary noise (lower frequency)
figure('Position', [100, 100, res_x, res_y]); 
x_noise = sigma_noise * randn(size(t));  % Gaussian white noise
% For stationary noise, we want to reduce frequency of significant changes.
x_noise = filter(ones(1, 50)/50, 1, x_noise); % Low-pass filter to smooth out noise
plot(t, x_noise, 'LineWidth', 1.5);
title('Stationary and Non-Deterministic: Noise', 'FontSize', labelFontSize);
xlabel('Time (s)', 'FontSize', axisFontSize);
ylabel('Amplitude', 'FontSize', axisFontSize);
grid on;
saveas(gcf, '_Stationary_NonDeterministic_Noise.png', 'png');
close;

% Non-Stationary and Deterministic: Fading sine wave (lower frequency)
figure('Position', [100, 100, res_x, res_y]); 
decay_factor = exp(-0.5 * t); % Exponential decay
x_fading_sine = A_sine * decay_factor .* sin(2 * pi * f_sine * t);
plot(t, x_fading_sine, 'LineWidth', 1.5);
title('Non-Stationary and Deterministic: Fading sine wave', 'FontSize', labelFontSize);
xlabel('Time (s)', 'FontSize', axisFontSize);
ylabel('Amplitude', 'FontSize', axisFontSize);
grid on;
saveas(gcf, '_NonStationary_Deterministic_Fading_Sine.png', 'png');
close;

% Non-Stationary and Non-Deterministic: Fading sine wave + noise (lower frequency)
figure('Position', [100, 100, res_x, res_y]); 
x_fading_noise = x_fading_sine + sigma_noise * randn(size(t)); % Fading sine + noise
x_fading_noise = filter(ones(1, 50)/50, 1, x_fading_noise); % Low-pass filter to smooth the noise
plot(t, x_fading_noise, 'LineWidth', 1.5);
title('Non-Stationary and Non-Deterministic: Fading sine + noise', 'FontSize', labelFontSize);
xlabel('Time (s)', 'FontSize', axisFontSize);
ylabel('Amplitude', 'FontSize', axisFontSize);
grid on;
saveas(gcf, '_NonStationary_NonDeterministic_Fading_Sine_Noise.png', 'png');
close;

% Cyclostationary Signal: Sine wave with cyclic variations (low frequency)
figure('Position', [100, 100, res_x, res_y]); 
x_noise = sigma_noise * randn(size(t));  

% Create a periodic modulation that will apply to the noise
modulation = 1 + modulation_depth * sin(2 * pi * modulation_frequency * t);  % Amplitude modulation with periodic cycles

% Apply the modulation to the noise to create a cyclostationary signal
x_cyclo = x_noise .* modulation;  % Noise modulated by periodic function

% Low-pass filter the result to smooth the noise and highlight the modulation
x_cyclo_filtered = filter(ones(1, 50)/50, 1, x_cyclo);  % Smoothing filter

% Plot the cyclostationary signal
plot(t, x_cyclo_filtered, 'LineWidth', 1.5);
title('Cyclostationary: Noise with Cyclic Modulation', 'FontSize', labelFontSize);
xlabel('Time (s)', 'FontSize', axisFontSize);
ylabel('Amplitude', 'FontSize', axisFontSize);
grid on;
saveas(gcf, '_Cyclostationary_Sine_with_Cyclic_Variation.png', 'png');
close;
