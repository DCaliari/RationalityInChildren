%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figure 6: Distribution of the preference types by school %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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


%% Set number of bootstraps. In the paper, 1000 samples

B = 5;

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

    

%% BOOTSTRAP STANDARD ERRORS

% Generate random indices for bootstrapping
y = randi(N, N, B); % Random resampling

for b = 1:B % Loop through bootstrap samples
    clearvars N p_par_new pi_par_new % Clear previous variables

    % Choices from the new resample
    y_temp = y(:, b);
    tempC = C(T(:, z), :);
    tempC = tempC(y_temp, :); % Apply the resample to the choices

    % Initial values for optimization
    p_par = 0.5;
    pi_par = ones(1, (g) * lc) / ((g) * lc);
    pi_par_old = pi_par; % Old value for distribution parameters

    par_dist = 1; it = 1; % Initialize distances and iteration counter
    p_par_old = p_par;

    % Optimization options for the bootstrap process
    options = optimoptions('fmincon', 'display', 'off', 'MaxFunctionEvaluations', 1e7,...
        'StepTolerance', 1e-9, 'FunctionTolerance', 1e-9, 'OptimalityTolerance', 1e-9, ...
        'FiniteDifferenceType', 'central' );

    LL_dist = 1; % Initialize log-likelihood distance
    tol_LL = 1e-6; % Tolerance for the log-likelihood distance

    % Optimization loop for bootstrap sample
    while LL_dist > tol_LL
        clearvars Q P % Clear matrices for conditional probabilities
        Q = []; % Initialize Q matrix
        p_par = p_par_old; % Use the old gamma parameter
        temp_par = repmat(p_par, 1, 4); % Replicate for variations

        % Calculate conditional probabilities matrices
        for i = 1:size(p_par, 1)
            for u = 1:lc
                P(:, u) = P_Rho_varying_type(temp_par(i, :), PER, u, R); 
            end
            temp = P;
            Q = [Q, temp]; % Concatenate calculated Q values
        end

        % Calculate the likelihood function for the bootstrap sample
        F = exp(tempC * log(Q)); 

        % Constraints for the first optimization problem
        lb = zeros(size(F, 2), 1);
        ub = ones(size(F, 2), 1);
        Aeq = ones(1, size(F, 2));
        beq = 1;

        % Maximization of the likelihood for the probability distribution
        [pi_par_new] = fmincon(@(pi_par) Log_lik_EB(pi_par, F), pi_par_old', [], [], Aeq, ...
            beq, lb, ub, [], options); 
        pi_par_new = pi_par_new'; % Transpose to match dimensions

        % Constraints for maximizing gamma
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
        p_par_new = fmincon(@(p_par) log_lik_model(p_par, pi_par_new, PER, lc, R, tempC), ...
            p_par_old, [], [], [], [], lb, ub, [], options);

        % Check for log-likelihood distance for convergence 
        LL_dist = log_lik_model(p_par_old, pi_par_new, PER, lc, R, tempC) - log_lik_model(p_par_new, pi_par_new, PER, lc, R, tempC);

        % Update parameters
        pi_par_old = pi_par_new; 
        p_par_old = p_par_new;
        it = it + 1; % Increment iteration counter
    end

    % Store bootstrap results
    RHObootstrap{treatment}(b, z) = sum(reshape(pi_par_new, 24, g)) * p_par_new; 
end % End of bootstrap sample loop

% Calculate standard errors from bootstrap results
STANDARDERR{treatment} = std(RHObootstrap{treatment}); % Store standard errors for the treatment

z % Display current subsample
end 

treatment % Display current treatment iteration

end % End of treatment loop

% load the saved bootstrapped estimates with 1000 samples

load bootstrap_Experiment1.mat


% Define x values for the x-axis
x = [1 2 3 4 5 6];             % Grades and Aggregate
x1 = x - 0.1;                  % Adjust x for School L (left offset)
x2 = x + 0.1;                  % Adjust x for School H (right offset)


% Repeat the data retrieval and plotting for School L in the second subplot
P_L = RHO{2}([1:5 11]);        % Preference data for School L (2nd data set)
S_L = STANDARDERR{2}([1:5 11]); % Standard errors for School L

% Plot preference data for School L
plot(x1(1:5), P_L(1:5), '*', 'MarkerSize', 8, 'Color', 'r')
hold on
errorbar(x1(1:5), P_L(1:5), S_L(1:5), S_L(1:5), 'LineStyle', '--', 'LineWidth', 0.8)

% Plot aggregate data for School L (6th point)
plot(x1(6), P_L(6), '*', 'MarkerSize', 8, 'Color', 'r', 'LineStyle', 'none')
hold on
errorbar(x1(6), P_L(6), S_L(6), S_L(6), 'LineStyle', 'none', 'LineWidth', 0.8, 'Color', 'r')

% Add numeric labels next to the stars for School L (offset right)
for i = 1:length(P_L)
    text(x1(i) + 0.1, P_L(i), num2str(P_L(i), '%.2f'), ...
        'FontSize', 10, 'FontName', 'Times', 'Color', 'r', 'HorizontalAlignment', 'left');
end

% Retrieve data for School H in the second data set
P_H = RHO{2}([6:10 12]);       % Preference data for School H
S_H = STANDARDERR{2}([6:10 12]); % Standard errors for School H

% Plot preference data for School H
plot(x2(1:5), P_H(1:5), '*', 'MarkerSize', 8, 'Color', 'b')
hold on
errorbar(x2(1:5), P_H(1:5), S_H(1:5), S_H(1:5), 'LineStyle', '--', 'LineWidth', 0.8, 'Color', 'b')

% Plot aggregate data for School H (6th point)
plot(x2(6), P_H(6), '*', 'MarkerSize', 8, 'Color', 'b', 'LineStyle', 'none')
hold on
errorbar(x2(6), P_H(6), S_H(6), S_H(6), 'LineStyle', 'none', 'LineWidth', 0.8, 'Color', 'b')

% Add numeric labels next to the stars for School H (offset left)
for i = 1:length(P_H)
    text(x2(i) - 0.1, P_H(i), num2str(P_H(i), '%.2f'), ...
        'FontSize', 10, 'FontName', 'Times', 'Color', 'b', 'HorizontalAlignment', 'right');
end

% Add a vertical dashed line at x = 5.5
xline(5.5, '--')

% Set the y-axis limits, x-axis limits, and tick labels for the second subplot
ylim([0.5 1]) % Limits for y-axis
xlim([0.5 6.5]) % Limits for x-axis
xticks([1 2 3 4 5 6]); % X-Tick positions
xticklabels({'1st grade', '2nd grade', '3rd grade', '4th grade', '5th grade', 'Aggregate'}); % X-Tick labels

% Add legend to the plot
legend('School L', '', '', '', 'School H', '', '', '', '', 'Location', 'southeast');

% Set font for current axes in the second subplot
set(gca, 'FontName', 'Times')
hold off

%% t-tests

% Collect the estimation of the consideration parameter
P1pp = RHO{2}([1:5 11]);
P2pp = RHO{2}([6:10 12]);

% Collect the standard errors
S1pp = STANDARDERR{2}([1:5 11]);
S2pp = STANDARDERR{2}([6:10 12]);


% T-test between 1st and 5th grade pens in School L and H
T1st5thGrade_L_pens = (P1pp(1)-P1pp(5))/sqrt(S1pp(1)^2 + S1pp(5)^2);
T1st5thGrade_H_pens = (P2pp(1)-P2pp(5))/sqrt(S2pp(1)^2 + S2pp(5)^2);


% T-test acroos schools at grade 1st, 5th, and total pens
TacrossSchool_1st_pens = (P1pp(1)-P2pp(1))/sqrt(S1pp(1)^2 + S2pp(1)^2);
TacrossSchool_5th_pens = (P1pp(5)-P2pp(5))/sqrt(S1pp(5)^2 + S2pp(5)^2);
TacrossSchool_Tot_pens = (P1pp(6)-P2pp(6))/sqrt(S1pp(6)^2 + S2pp(6)^2);

% Collect the results in an array
TT = [
T1st5thGrade_L_pens ;
T1st5thGrade_H_pens;


TacrossSchool_1st_pens;
TacrossSchool_5th_pens;
TacrossSchool_Tot_pens];

Pvalue = normcdf(TT)*2; % two-tailed p-value

% Saving tables summarizing the t-tests and the comparisons

section_A1OA_1 = array2table([[P1pp(1);P2pp(1)], [P1pp(5);P2pp(5)], Pvalue(1:2)] , ...
    "RowNames", {'Pens -School L', 'Pens - School H'}, "VariableNames",{'1st','5th','pvalue'})

section_A1OA_1_2 = array2table([[P1pp(1);P1pp(5);P1pp(6)], [P2pp(1);P2pp(5);P2pp(6)], Pvalue(3:end)], ...
    "RowNames", {'Pens - 1st', 'Pens - 5th', 'Pens - aggregate'}, "VariableNames",{'School L','School H','pvalue'})

