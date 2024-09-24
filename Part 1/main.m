clear
close all
clc

addpath(genpath("Data"));
addpath(genpath("plotFunctions"));

%% Load data
n = 6;      % Samples - 6 anemometers
data = struct([]);
% Read data
for i = 1:n
    
    file_name = "u" + num2str(i) + ".txt";
    fprintf("Reading: " + file_name +"\n");
    data(i).u = readmatrix(file_name)';

end

%% Merge data into matrix form (row-wise)
% Pre-allocate memory
u_meas = zeros(n, length(data(i).u));
for i = 1:n
    u_meas(i, :) = data(i).u;
end

f = 20e3;                           % Frequency in Hz
t = 1/f * (0:size(u_meas, 2)-1);    % Sampling times

%% 1.1 Velocity Signal in the spatial domain
U       = mean(u_meas, 2);          % Mean Velocity
u       = u_meas - U;               % Perturbations
u_RMS   = sqrt(mean(u.^2, 2));      % Mean Squared Velocity Error
I       = u_RMS ./ U;               % Turbulence itensity
l       = t .* U;                   % Distances l - Taylor's frozen flow hypothesis

plotAnemometers(l, u_meas, U, 500)  % Plot raw anemometer data and histograms    

%% Errors on Taylor Frozen flow
% Numerical estimation of mean derivative
u_diff = diff(u, 1, 2);             
dudt = u_diff * f;
dudt_mean = mean(abs(dudt), 2);

% Small-scale maximal correlation length
del = U .* u_RMS ./ dudt_mean;

% Cross-correlation to check frozen hypothesis
lag_idx = round(1 ./ U(1) * f);
crosscorr = mean(u(1, 1:end-lag_idx) .* u(2, lag_idx+1:end)) / (u_RMS(1) * u_RMS(2));

%% 1.2 Correlation Length of the velocity signal
c_lag = zeros(size(u));             % Autocorrelation lags
for i = 1:n 
    [c_lag(i, :), ~] = autocorr(u(i, :), numLags = size(u, 2)-1);
end

%%
idx = 19000;                        % Consider only 1:idx samples
c_lag = c_lag(:, 1:idx);            % Cross-correlations
l_lag = l(:, 1:idx);                % Corresponding lengths
plotCorrelations(c_lag, l_lag)      % Plot correlation data

%%
Lint  = zeros(n, 1);                % Integral lengths
Lc    = zeros(n, 1);                % Length for correlation to drop by 1/e
% Calculate relevant distances
for i = 1:n
    % Calculate integral length Lint
    idx_zero = find(c_lag(i, :)<0, 1, 'first');                         % Find first zero-crossing point                    
    Lint(i) = trapz(l_lag(i, 1:idx_zero-1), c_lag(i, 1:idx_zero-1));    % Numerical quadrature
    Lint(i) = Lint(i) + 0.5 * (l(i, idx_zero) - l(i, idx_zero-1)) .* c_lag(i, idx_zero) ...
        ./ (c_lag(i, idx_zero) - c_lag(i, idx_zero-1));

    % Calculate correlation length Lc 
    idx = find(c_lag(i, :) <= 1/exp(1), 1, 'first');
    Lc(i) = interp1([c_lag(i, idx-1) c_lag(i, idx)], ...
        [l_lag(i, idx-1) l_lag(i, idx)], 1/exp(1));
end

%% 1.3 Energy Spectrum
n_pos_freq = floor(size(u, 2) / 2);         % Number of positive frequencies
L = size(u, 2);                             % Length of signal (num of samples)
T = L / f;                                  % Total sampling time
freq = f / L * (0:n_pos_freq);              % Assosciated frequencies
k = 2 * pi * freq ./ U;                     % Assosciated wavenumbers

% pre-allocate memory
E = zeros(n, length(k));
P = zeros(n, 1);
for i = 1:n
    
    % ifft spectrum
    fft_time = ifft(u(i, :));

    % Consider only positive frequencies (negative ones are complex conjugates)
    fft_time = fft_time(1:n_pos_freq+1);
    
    % Energy calculation -> reduce to sheet formula by change of variables
    E(i, :) = T * U(i) / (2*pi) * abs(fft_time).^2;
    
end

%%
% Number or resampling points for filtering
num_samples = 100000;  

% Pre-allocate memory
E_filtered = zeros(n, num_samples);
k_filtered = zeros(n, num_samples);

% Calculate Parseval's error and filter
for i = 1:n
    % Resample points
    log_k_sampled = linspace(log10(k(i, 2)), log10(k(i, end)), num_samples);        % log-sapced wavenumbers
    E_sampled = interp1(log10(k(i, 2:end)), E(i, 2:end), log_k_sampled, 'linear');  % Resample E(k)
    E_filtered(i, :) = smoothdata(E_sampled, 2,"gaussian", 800);                    % Gaussian smoothening
    k_filtered(i, :) = 10 .^ log_k_sampled;                                         % Back to linear scale
    
end

% Parseval's error
P_err = 1 - P ./ (0.5 * u_RMS.^2);  

% Graphically estimates scales
visE = [250 180 150 130 110 100]';          % Viscosity divergence wavenumber
etaE = 2 * pi ./ (30 * visE) ;              % Kolmogorov 1/30 pre-factor
ketaE = 2 * pi ./ etaE;                     % Kolmogorov wavenumber
kintE   = [2.4 2.1 1.7 1.5 1.4 1.2]';       % Integral scale wavenumber
LEint = 2 * pi ./ kintE;                    % Integral scale estimate

%% PLot K41 energy spectrum
plotK41(k_filtered, E_filtered, visE, kintE)

%% 1.4 Dissipation rate and Different Reynolds Numbers
eps = 0.5 * u_RMS.^3 ./ Lc;                     % Estimate of specific dissipatino rate
nu = 1.48e-5;                                   % Air kinematic viscosity at 20C
lambda = sqrt(15 * nu ./ eps) .* u_RMS;         % Taylor lengthscale
Re_lam = u_RMS .* lambda / nu;                  % Taylor Reynolds number
Re = u_RMS .* Lc / nu;                          % Outer Reynolds number

plotReynolds(Re, Re_lam, eps, I)                % Plot eps, I, Re_lam, Re

%% 1.5 Turbulence decay
TKE = 1.5 * u_RMS.^2;                           % Turbulence kinetic energy

%% 1. Fit with fitnlm from Statistics and Machine Learning Toolbox
% Create table of distance, TKE
tbl = table((1:n)', TKE);

% Non-linear function to fit
modelfun = @(b,x) b(1) * (x(:, 1) - b(2)).^b(3);

% Solve non-linear fit problem
beta0 = [1, 0, -1];
mdl = fitnlm(tbl, modelfun, beta0);
beta = mdl.Coefficients{:, 'Estimate'};

% Pltting of experimental/fitted data
plotAutomaticFitting(beta, TKE, modelfun)       % Plot non-linear fit
d0 = beta(2);                                   % Virtual origin from fit
h = beta(3) ./ (2 + beta(3));                   % Scaling exponent from fit
%% 2. Graphical Fit
% Range of values of d0 used for graphical fit
d0_range = linspace(0.5, 0.8, 8);               % Range of d_0 to be explored
X = (1:n)' - d0_range;                          % Matrix of d_d0 for all anemometers

% pre-allocate memory
coeff = zeros(n, 2);

% Fit functions
for i = 1:length(d0_range)
    % Least squares linear fit
    coeff(i, :) = polyfit(log10(X(:, i)), log10(TKE), 1);   
end

% Plot fits
plotGraphicalFitting(TKE, d0_range, coeff, n)       

%% 3. Integral scale fit
% Fit TKE with LC to calculate scaling exponent
pol = polyfit(log10(Lc), log10(TKE), 1);
h = pol(1) / 2;

% Plot integral scale fit
plotIntegralScaleFitting(TKE, Lc, pol)
%%
% Loitsyankii appears to be best theoretical prediction
h = - 5/2;

% Fit  eps^((1-h)/(2h)) = A*d+B
pol = polyfit((1:n)', TKE.^((1-h)/(2*h)), 1);
d0 = -pol(2)/pol(1);

plotVirtualOriginFit(TKE, h, pol);
%% Plot energy spectrum over k - with theoretical predictions
plotEnergySpectrumDecay(k_filtered, E_filtered)