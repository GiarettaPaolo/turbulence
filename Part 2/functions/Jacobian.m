%%% DESCRIPTION -----------------------------------------------------------
%   Jacobian of the KSE flow map: J=du(t)/du(0)


%%% INPUTS ----------------------------------------------------------------
%   u0          reference point of the Jacobian (column state vector)
%   t           integration time interval
%   epsilon     perturbation magnitude for finite difference derivatrives
%   dt          step size in time integrations
%   L           domain length
%   N           spatial resolution
%   symm        center symmetry (true/false boolean)


%%% OUTPUTS ---------------------------------------------------------------
%   J       Jacobian matrix


function J = Jacobian(u0,t,epsilon,dt,L,N,symm)
    n = length(u0);

    % Pre-allocate memory
    J = zeros(n, n);
    I = eye(n, n);
    for i=1:n
        
        % Use i-th basis vector as perturbation 
        u0_plus  = u0 + epsilon * I(:, i);
        u0_minus = u0 - epsilon * I(:, i);

        % Evolve the vectors in time through the numerical procedure
        [ut_plus, ~] = KSE_integrate(u0_plus, t, dt, 0, L, N, symm);
        [ut_minus, ~] = KSE_integrate(u0_minus, t, dt, 0, L, N, symm);

        % Compute Jacobian through central differencing
        J(:, i) = (ut_plus - ut_minus) / (2 * epsilon);
        

    end
end