clear
close all
clc

%% 4.2 - Quantitative characterization
N           = 64;               % Number of interval Discretizations
T           = 1e4;              % Integration time
M           = 5e3;              % Number renormalizations
dt          = 0.1;              % Time step
p           = 10;               % Number of Lyapunov exponents
epsilon     = 1e-8;             % Central differencing discretization step

L    = [22.0 38.6 38.6];        % Domain length - vector form 
symm = [false false true];      % Reflection Symmetry solution - vector form


% Initial conditions
u0_1 = @(x, L) sin(2*pi * x / L) + 3/2 * cos(4*pi * x / L); 
u0_2 = @(x, L) sin(2*pi * x / L) + 3/2 * cos(4*pi * x / L); 
u0_3 = @(x, L) sin(2*pi * x / L);                           
u0_vect = {u0_1, u0_2, u0_3};

% Create solution structure array
sol = struct([]);

% Integration time step
tau = T/M;
for i = 1:length(L)
        
    % Compute Lyapunov exponents for each problem
    
    % Calculate initial state vector
    x = domain(L(i), N);
    u0 = u0_vect{i}(x, L(i));
    u = field2vector(u0, N, symm(i));

    % Pre-allocate solution of exponents
    X = zeros(p, M);

    % Initialize orthogonal perturbation matrix
    Q = eye(size(u, 1), p);
    
    % Algorithm
    for j = 1:M
        
        % Compute Jacobian of time step evolution
        J = Jacobian(u, tau, epsilon, dt, L(i), N, symm(i));

        % Map the deviation vectors
        V = J * Q;

        % Compute QR factorization
        [Q, R] = qr(V);

        % Update Lyapunov exponents
        X(:, j) = log(abs(diag(R)));

        % Evolve u
        [u, ~] = KSE_integrate(u, tau, dt, 0, L(i), N, symm(i));

        % Preparare for next iteration
        Q = Q(:, 1:p);

    end

    % Divide by time to get running estimates of exponents
    X = cumsum(X, 2) ./ (1:M) / tau;
    
    % Compute Kaplan-Yorke dimension
    Xend = X(:, end);
    Xcum = cumsum(Xend);
    idx = find(Xcum >= 0, 1, 'last');
    if ~isempty(idx) && idx < p
        Dky = idx + Xcum(idx) / abs(Xend(idx+1));
    else
        Dky = p;
        fprintf('Errror, not enough Lyapunov exponents p to determine Kaplan-York dimension')
    end


    % Build output structure
    sol(i).L    = L(i);
    sol(i).x    = x;
    sol(i).symm = symm(i);
    sol(i).u0   = u0;
    sol(i).X    = X;
    sol(i).Dky  = Dky;
    sol(i).Xend = Xend;

end

% Save solution
save("solutionLyapunov.mat", "sol")

%% Plots
plotLyapunovExponents(sol);
