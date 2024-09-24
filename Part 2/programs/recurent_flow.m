clear 
close all
clc
%%

N           = 64;               % Number of interval Discretizations
T           = 2e3;              % Integration time
dt          = 0.1;              % Time step
dt_snapshot = 0.5;              % Time inbetween snapshots

L    = 38.6;                    % Domain length 
symm = true;                    % Reflection Symmetry solution 

% Initial conditions
u0_fun = @(x, L) sin(2*pi * x / L);                           

    
% Build domain
[x, ~] = domain(L, N);

% Set initial solution
u0 = u0_fun(x, L);

% Transform into state vector and integrate 
v0 = field2vector(u0, N, symm);
[vsol, tsol] = KSE_integrate(v0, T, dt, dt_snapshot, L, N, symm);


% Transform vector into solution space
% Pre-allocate memory
ut = zeros(N, size(vsol, 2));
vt = zeros(size(v0, 1), size(vsol, 2));
for j = 1:size(vsol, 2)
    ut(:, j) = vector2field(vsol(:, j), N, symm); 
    vt(:, j) = vsol(:, j);
end

% Build reccurence relation
% Pre-allocate memory
n = length(tsol);
r = nan(n, n);
for j = 2:n
    % Calculate recurrence - vectorized form (i -> t, j -> T)
    r(j, 2:j) = vecnorm(vt(:, j) - vt(:, j-1:-1:1), 2, 1);
end

% Normalize recurrence matrix
r = r ./ vecnorm(vt, 2)';


%% Reccurence guesses
T_max = 200;                                % Maximal period of UPOs
idx_max = floor(T_max / dt_snapshot) + 1;   % Corresponding index for Tmax
idx_t = floor(T / dt_snapshot) + 1;         % Corresponding index for tmax
mat = r(1:idx_t, 1:idx_max);                % Extract submatrix of interest

p = 10;                                     % Number of elements to pick
idx_spacing = 50;                           % Minimum distance between indexes 

% Sort the matrix elemetns 
[~, idx] = sort(mat(:));        
[row, col] = ind2sub(size(mat), idx);

% Find indexes, but don't consider those too clsoe to each other
recurrence_guess(:, 1) = [row(1); col(1)];

i = 1;
while size(recurrence_guess, 2) < p
     
     % Check wether one index is already close enough 
     i = i + 1;
     truth_mat = abs(recurrence_guess - [row(i); col(i)]) < idx_spacing;
     truth_vect = and(truth_mat(1, :), truth_mat(2, :));
     if any(truth_vect)
         continue 
     end
    
     % Check wheter period is too small
     if col(i) < idx_spacing
         continue
     end
     
     % Concatenate solutions
     recurrence_guess = horzcat(recurrence_guess, [row(i); col(i)]); %#ok<AGROW>
        
end


%% Plots and recurrence indicator
plotRecurrence(tsol, mat, recurrence_guess)     % Recurrence contours plots

%% Periodic orbits

% Preallocate solution memory
v_best_vect = zeros(size(vt, 1), size(recurrence_guess, 2));
T_best_vect = zeros(1, size(recurrence_guess, 2));
orbits = cell(5, size(recurrence_guess, 2));

for i = 1:size(recurrence_guess, 2)
    
    v_guess = vt(:, recurrence_guess(1, i));                % Extract initial condition
    T_guess  = (recurrence_guess(2, i) - 1) * dt_snapshot;  % Extract initial period guess

    % Apply search4PO
    [v_best, T_best, flag] = search4PO(v_guess, T_guess, dt, L, N, symm); % Finde UPO
    
    % Append
    v_best_vect(:, i) = v_best;
    T_best_vect(i) = T_best;
    
    % Propagate orbit
    [vsol, t_sol] = KSE_integrate(v_best, T_best, dt, dt, L, N, symm);

    % Store solution
    orbits{1, i} = t_sol;
    orbits{2, i} = vsol;
    orbits{3, i} = flag;
    orbits{4, i} = T_best;
    orbits{5, i} = recurrence_guess(1, i)-1;

end

% Save solution
save("orbits.mat", "orbits")

%% Plots
plotOrbits(vt, orbits, false)



