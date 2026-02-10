%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ECMA MODEL ESTIMATIONS %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

create_warp_datasets

[DATA1,DATA2,~,~,~,~] = dataset_constructions(DATASET(:,1:6),n); % use the function "dataset_constructions" to obtain the dataset for estimation

C_pencils = DATA1; % These are the choices from the pencils
C_pens = DATA2; % These are the choices from the pens

%% Here I load data on school, groups, class, etc...

load groups.mat 

load gender_class_school.mat

spring = group < 8; % I focus on the pupils who did the experiment in the autumn



%% ESTIMATES BY GENDER


T(:,1) = gender & class == 1 & ~spring;
T(:,2) = gender & class == 2 & ~spring;
T(:,3) = gender & class == 3 & ~spring;
T(:,4) = gender & class == 4 & ~spring;
T(:,5) = gender & class == 5 & ~spring;
T(:,6) = ~gender & class == 1 & ~spring;
T(:,7) = ~gender & class == 2 & ~spring;
T(:,8) = ~gender & class == 3 & ~spring;
T(:,9) = ~gender & class == 4 & ~spring;
T(:,10) = ~gender & class == 5 & ~spring;
T(:,11) = gender & ~spring;
T(:,12) = ~gender & ~spring;


iter=1;


%% Begin the estimation process
for treatment = 1:2
    if treatment == 1 % Focus on pencils
        C = C_pencils;
    elseif treatment == 2 % Focus on pens
        C = C_pens;
    end

    iter = 1; % Iteration counter for the optimization loop

    % Loop through each subpopulation defined in T
    for z = 1:size(T, 2) 

        clearvars N p_par_new pi_par_new F y % Clear previous variables

        g = 1; % Number of gamma parameters = 1 (unique consideration parameter)

        N = size(C(T(:, z), :), 1); % Number of individuals in the current subpopulation

        % Initial value for gamma parameter
        p_par = 0.5;

        % Check if the starting point modifies the estimates
        if iter == 1
            % Starting point for the probability distribution "pi" (uniform distribution)
            pi_par = ones(1, (g) * lc) / ((g) * lc); 
        else
            % Random starting point for the probability distribution "pi"
            pi_par = rand(1, (g) * lc); 
            pi_par = pi_par ./ sum(pi_par); % Normalize to sum to one
        end

        pi_par_old = pi_par; % Store the old parameters

        tol_par = 1e-9; % Tolerance for parameter convergence
        par_dist = 1; it = 1; % Initialize distances
        p_par_old = p_par; % Store the old gamma parameter for convergence checks

        % Optimization options
        options = optimoptions('fmincon', 'display', 'off', 'MaxFunctionEvaluations', 1e7,...
            'StepTolerance', 1e-9, 'FunctionTolerance', 1e-9, 'OptimalityTolerance', 1e-9, ...
            'FiniteDifferenceType', 'central' );

        LL_dist = 1; % Initialize log-likelihood distance
        tol_LL = 1e-8; % Tolerance for log-likelihood differences

        % Optimization loop for parameters
        while LL_dist > tol_LL
            clearvars Q P % Clear matrices for conditional probabilities
            Q = []; % Initialize Q matrix
            p_par = p_par_old; % Use the old gamma parameter

            temp_par = repmat(p_par, 1, 4); % Replicate the gamma parameter for alternatives

            % Calculate conditional probabilities matrices
            for i = 1:size(p_par, 1)
                for u = 1:lc
                    P(:, u) = P_Rho_varying_type(temp_par(i, :), PER, u, R); 
                end
                temp = P;
                Q = [Q, temp]; % Concatenate calculated Q values
            end

            % Calculate the likelihood function
            F = exp(C(T(:, z), :) * log(Q)); 

            % Constraints for the first optimization problem
            lb = zeros(size(F, 2), 1); % Lower bound
            ub = ones(size(F, 2), 1); % Upper bound
            Aeq = ones(1, size(F, 2)); % Equality constraint: sum to one
            beq = 1;

            % Maximization of the likelihood with respect to the probability distribution
            [pi_par_new] = fmincon(@(pi_par) Log_lik_EB(pi_par, F), pi_par_old', [], [], Aeq, ...
                beq, lb, ub, [], options); 
            pi_par_new = pi_par_new'; % Transpose to match dimensions

            % Constraints for the second maximization problem (gamma parameters)
            lb = 0;
            for i = 1:size(p_par_old, 1) - 1    
                lb = [lb; p_par_old(i)];
            end
            ub = [];
            for i = 1:size(p_par_old, 1) - 1 
                ub = [ub; p_par_old(1 + i)];
            end
            ub = [ub; 1];

            % Maximization of the likelihood with respect to gamma
            [p_par_new, ~, ~, ~, ~, grad, hessian] = fmincon(@(p_par) log_lik_model(p_par, pi_par_new, PER, lc, R, C(T(:, z), :)), p_par_old, [], [], [], [], lb, ub, [], options); 

            % Calculate log-likelihood distance for convergence check
            LL_dist = log_lik_model(p_par_old, pi_par_new, PER, lc, R, C(T(:, z), :)) - log_lik_model(p_par_new, pi_par_new, PER, lc, R, C(T(:, z), :)); 

            % Update parameters for the next iteration of the while loop
            pi_par_old = pi_par_new;
            p_par_old = p_par_new;
            it = it + 1; % Increment iteration counter
        end

        % Store the estimated gamma and probability distribution
        parameters{treatment}(:, z) = p_par_new; 
        preferences{treatment}(z, :) = pi_par_new; 

        % Store average gamma if there are more than one
        RHO{treatment}(z, 1) = sum(reshape(preferences{treatment}(z, :), 24, g)) * parameters{treatment}(:, z); 

        HESSIAN{treatment}{z, 1} = hessian; % Store the hessian matrix for the second optimization problem
        fs{treatment}{z, 1} = F; % Store the likelihood function values

    

end % End of treatment loop
treatment % Display current treatment iteration

end
% load the saved bootstrapped estimates with 1000 samples

% load bootstrap_Experiment1_gender.mat


% Define x values for the x-axis
x = [1 2 3 4 5 6];             % Grades and Aggregate
x1 = x - 0.1;                  % Adjust x for Girls (left offset)
x2 = x + 0.1;                  % Adjust x for Boys (right offset)


subplot(1,2,1)
% Retrieve data for School L
P_L = RHO{1}([1:5 11]);        % Preference data for Girls (grades and aggregate)

% Plot preference data for Girls
plot(x1(1:5), P_L(1:5), '*', 'MarkerSize', 8, 'Color', 'r', 'LineStyle', '--') % Markers for each grade
hold on
% Plot aggregate data for Girls (6th point)
plot(x1(6), P_L(6), '*', 'MarkerSize', 8, 'Color', 'r', 'LineStyle', 'none')
hold on
% Retrieve data for Boys
P_H = RHO{1}([6:10 12]);       % Preference data for School H

% Plot preference data for Boys
plot(x2(1:5), P_H(1:5), '*', 'MarkerSize', 8, 'Color', 'b', 'LineStyle', '--') % Markers for each grade
hold on
% Plot aggregate data for Boys (6th point)
plot(x2(6), P_H(6), '*', 'MarkerSize', 8, 'Color', 'b', 'LineStyle', 'none')

% Add a vertical dashed line at x = 5.5
xline(5.5, '--')

% Set the y-axis limits, x-axis limits, and tick labels
ylim([0.5 1]) % Limits for y-axis
xlim([0.5 6.5]) % Limits for x-axis
xticks([1 2 3 4 5 6]); % X-Tick positions
xticklabels({'1st grade', '2nd grade', '3rd grade', '4th grade', '5th grade', 'Aggregate'}); % X-Tick labels

% Add legend to the plot
legend('Female','' , 'Male', '', 'Location', 'southeast');

% Set font for current axes
set(gca, 'FontName', 'Times')
hold off

subplot(1,2,2)
% Retrieve data for School L
P_L = RHO{2}([1:5 11]);        % Preference data for Girls (grades and aggregate)

% Plot preference data for Girls
plot(x1(1:5), P_L(1:5), '*', 'MarkerSize', 8, 'Color', 'r', 'LineStyle', '--') % Markers for each grade
hold on
% Plot aggregate data for Girls (6th point)
plot(x1(6), P_L(6), '*', 'MarkerSize', 8, 'Color', 'r', 'LineStyle', 'none')
hold on
% Retrieve data for Boys
P_H = RHO{2}([6:10 12]);       % Preference data for School H

% Plot preference data for Boys
plot(x2(1:5), P_H(1:5), '*', 'MarkerSize', 8, 'Color', 'b', 'LineStyle', '--') % Markers for each grade
hold on
% Plot aggregate data for Boys (6th point)
plot(x2(6), P_H(6), '*', 'MarkerSize', 8, 'Color', 'b', 'LineStyle', 'none')

% Add a vertical dashed line at x = 5.5
xline(5.5, '--')

% Set the y-axis limits, x-axis limits, and tick labels
ylim([0.5 1]) % Limits for y-axis
xlim([0.5 6.5]) % Limits for x-axis
xticks([1 2 3 4 5 6]); % X-Tick positions
xticklabels({'1st grade', '2nd grade', '3rd grade', '4th grade', '5th grade', 'Aggregate'}); % X-Tick labels

% Add legend to the plot
legend('Female','' , 'Male', '', 'Location', 'southeast');

% Set font for current axes
set(gca, 'FontName', 'Times')
hold off

