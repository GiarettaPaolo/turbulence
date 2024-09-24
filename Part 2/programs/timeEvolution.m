clear 
close all
clc

%% 4 Chaotic Behavior of the KSE
%% 4.1 Qualitative investigation

N           = 64;               % Number of interval Discretizations
T           = 750;              % Integration time
dt          = 0.1;              % Time step
dt_snapshot = 1;                % Time inbetween snapshots

L    = [22 18 17];              % Domain length - vector form 
symm = [false false false];     % Reflection Symmetry solution - vector form


% Initial conditions
u0_1 = @(x, L) sin(2*pi * x / L) + 3/2 * cos(4*pi * x / L); 
u0_2 = @(x, L) sin(2*pi * x / L) + 3/2 * cos(4*pi * x / L); 
u0_3 = @(x, L) sin(2*pi * x / L);                           
u0_vect = {u0_1, u0_1, u0_1};

% Create solution structure array
sol = struct([]);


% Loop over the required problems and integrate
for i = 1:length(L)
    
    % Build domain
    [x, ~] = domain(L(i), N);

    % Set initial solution
    u0 = u0_vect{i}(x, L(i));
    
    % Transform into state vector and integrate 
    v0 = field2vector(u0, N, symm(i));
    [vsol, tsol] = KSE_integrate(v0, T, dt, dt_snapshot, L(i), N, symm(i));
    
    % Build output structure
    sol(i).L    = L(i);
    sol(i).x    = x;
    sol(i).symm = symm(i);
    sol(i).u0   = u0;
    sol(i).tsol = tsol;

    % Transform vector into solution space
    % Pre-allocate memory
    sol(i).ut = zeros(N, size(vsol, 2));
    for j = 1:size(vsol, 2)
        sol(i).ut(:, j) = vector2field(vsol(:, j), N, symm(i)); 
    end

end

%% Space-Time contour plots
plotSpaceTimeCountour(sol)


