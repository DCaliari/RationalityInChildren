%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figure 6: Distribution of preferences by school %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create datasets needed for the analysis
create_warp_datasets

% Obtain the dataset for estimation using the function "dataset_constructions"
[DATA1, DATA2, ~, ~, ~, ~] = dataset_constructions(DATASET(:, 1:6), n); 

C_pencils = DATA1; % Store the choices from the pencils
C_pens = DATA2;    % Store the choices from the pens

%% Load additional data on school, groups, class, etc...
load groups.mat 
load gender_class_school.mat

% Identify pupils who participated in the autumn experiment
spring = group < 8; 

%% Create subpopulations based on school and class
T(:, 1) = school == 1 & class == 1 & ~spring;
T(:, 2) = school == 1 & class == 2 & ~spring;
T(:, 3) = school == 1 & class == 3 & ~spring;
T(:, 4) = school == 1 & class == 4 & ~spring;
T(:, 5) = school == 1 & class == 5 & ~spring;
T(:, 6) = school == 4 & class == 1 & ~spring;
T(:, 7) = school == 4 & class == 2 & ~spring;
T(:, 8) = school == 4 & class == 3 & ~spring;
T(:, 9) = school == 4 & class == 4 & ~spring;
T(:, 10) = school == 4 & class == 5 & ~spring;
T(:, 11) = school == 1 & ~spring;
T(:, 12) = school == 4 & ~spring;

%% Begin the estimation process
for treatment = 1:2
    if treatment == 1 % Focus on pencils
        C = C_pencils;
    elseif treatment == 2 % Focus on pens
        C = C_pens;
    end

    iter = 1; % Iteration counter for optimization

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

        % Store old parameters for convergence checking
        pi_par_old = pi_par; 

        tol_par = 1e-9; % Tolerance for parameter convergence
        par_dist = 1; it = 1; % Initialize distances and iteration counter
        p_par_old = p_par; % Store the old gamma parameter

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

            temp_par = repmat(p_par, 1, 4); % Replicate gamma parameter for alternatives

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
            ub = ones(size(F, 2), 1);  % Upper bound
            Aeq = ones(1, size(F, 2));  % Vector for probabilities to sum to one
            beq = 1;                     % Equality constraint value

            % Maximization of the likelihood with respect to the probability distribution
            [pi_par_new] = fmincon(@(pi_par) Log_lik_EB(pi_par, F), pi_par_old', [], [], Aeq, ...
                beq, lb, ub, [], options); 
            pi_par_new = pi_par_new'; % Transpose to match dimensions

            % Constraints for maximizing gamma
            lb = 0;
            for i = 1:size(p_par_old, 1) - 1    
                lb = [lb; p_par_old(i)];
            end
            ub = []; % Upper bound initialization
            for i = 1:size(p_par_old, 1) - 1 
                ub = [ub; p_par_old(1 + i)];
            end
            ub = [ub; 1]; % Ensure the last parameter stays between 0 and 1

            % Maximization of the likelihood with respect to gamma
            [p_par_new, ~, ~, ~, ~, grad, hessian] = fmincon(@(p_par) log_lik_model(p_par, pi_par_new, PER, lc, R, C(T(:, z), :)), ...
                p_par_old, [], [], [], [], lb, ub, [], options); 

            % Calculate log-likelihood distance for convergence check
            LL_dist = log_lik_model(p_par_old, pi_par_new, PER, lc, R, C(T(:, z), :)) - ...
                      log_lik_model(p_par_new, pi_par_new, PER, lc, R, C(T(:, z), :)); 

            % Update parameters for next iteration of the while loop
            pi_par_old = pi_par_new;
            p_par_old = p_par_new; 
            it = it + 1; % Increment iteration counter
        end

        % Store the estimated gamma and probability distribution
        parameters{treatment}(:, z) = p_par_new; 
        preferences{treatment}(z, :) = pi_par_new; 

        % Store average gamma if there are more than one
        RHO{treatment}(z, 1) = sum(reshape(preferences{treatment}(z, :), 24, g)) * parameters{treatment}(:, z); 

        HESSIAN{treatment}{z, 1} = hessian; % Store hessian matrix for the second optimization problem
        fs{treatment}{z, 1} = F; % Store the likelihood function values
    end % End of subpopulation loop
end % End of treatment loop

%% PLOTS TYPE DISTRIBUTION BY SCHOOLS

% Define categorical labels for the types
cat1 = categorical({'DLFS','DLSF','DFLS','DFSL','DSLF','DSFL','LDFS','LDSF','LFDS','LFSD','LSDF',...
    'LSFD','FDLS','FDSL','FLDS','FLSD','FSDL','FSLD','SDLF','SDFL','SLDF','SLFD','SFDL','SFLD'});

% Reorder the categories for plotting
cat1 = reordercats(cat1, {'DLFS','DLSF','DFLS','DFSL','DSLF','DSFL','LDFS','LDSF','LFDS','LFSD','LSDF',...
    'LSFD','FDLS','FDSL','FLDS','FLSD','FSDL','FSLD','SDLF','SDFL','SLDF','SLFD','SFDL','SFLD'});

% Define categorical labels for the second set of types
cat2 = categorical({'YRBG','YRGB','YBRG','YBGR','YGRB','YGBR','RYBG','RYGB','RBYG','RBGY','RGYB',...
    'RGBY','BYRG','BYGR','BRYG','BRGY','BGYR','BGRY','GYRB','GYBR','GRYB','GRBY','GBYR','GBRY'});

% Reorder the categories for the second plotting
cat2 = reordercats(cat2, {'YRBG','YRGB','YBRG','YBGR','YGRB','YGBR','RYBG','RYGB','RBYG','RBGY','RGYB',...
    'RGBY','BYRG','BYGR','BRYG','BRGY','BGYR','BGRY','GYRB','GYBR','GRYB','GRBY','GBYR','GBRY'});

% Define positions for x-axis ticks
x = [1 2 3 4 5];
x1 = x - 0.1; % Adjusted x for School L
x2 = x + 0.1; % Adjusted x for School H


b2 = bar(cat2, preferences{2}(11:12, :)); % Bar plot for second treatment
set(gca, 'FontName', 'Times'); % Set font
ylim([0 0.3]); % Set y-axis limits
legend('School L', 'School H'); % Add legend
set(gca, 'FontName', 'Times'); % Set font
b2(1).FaceColor = 'r'; % Set color for School L
b2(2).FaceColor = 'b'; % Set color for School H

% Set the figure to landscape orientation
set(gcf, 'PaperOrientation', 'landscape');

% Set the figure size (width and height in inches)
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperSize', [20 8.5]);  % Set width and height of the paper

% Adjust the position and size of the plot to fill the entire page
set(gcf, 'PaperPosition', [0 0 20 8.5]);  % Set [left bottom width height]

% Adjust the figure window size to match the paper size (optional)
set(gcf, 'Units', 'inches');
set(gcf, 'Position', [1 1 20 8.5]);  % Set [left bottom width height]




